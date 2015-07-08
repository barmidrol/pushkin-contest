set :branch, 'master'
set :rails_env, 'production'
set :unicorn_env, 'production'

server '46.101.238.197',  user: 'deployer', roles: %w{app web db sidekiq}
