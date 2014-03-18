require 'bundler/capistrano'
require 'capistrano-unicorn'
require 'rvm/capistrano'
require 'bundler/capistrano'
# require 'sidekiq/capistrano'

set :application, "pushkin"

set :scm, :git
set :scm_verbose, false
set :repository,  'git@github.com:Saicheg/pushkin-contest.git'

set :deploy_via, :remote_cache
set :keep_releases, 5
set :use_sudo, false

set :branch, "master"
set :user, 'deployer'

set :rails_env, 'production'

set :deploy_to,  "/var/www/#{application}"

set :domain, "#{user}@107.170.100.126"

role(:web) { domain }
role(:app) { domain }
role(:db, primary: true) { domain }

ssh_options[:forward_agent] = true
default_run_options[:pty] = false

set :using_rvm, true
set :rvm_ruby_string, '2.1.1'
set :rvm_type, :user

after 'deploy:finalize_update', "#{application}:symlink"

namespace :"#{application}" do
  desc "Make symlink for additional #{application} files"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

# after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'   # app preloaded
# after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)

after "deploy:assets:precompile", 'deploy:migrate_db'

namespace :deploy do
  task :migrate_db, :roles => :db do
    run "cd #{release_path}/ && bundle exec rake --trace db:migrate RAILS_ENV=#{rails_env}"
  end
end
