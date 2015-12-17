set :branch, 'master'
set :rails_env, 'production'
set :unicorn_env, 'production'

server '46.101.183.88',  user: 'deployer', roles: %w{app web db sidekiq}
