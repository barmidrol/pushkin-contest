set :branch, 'master'
set :rails_env, 'production'
set :unicorn_env, 'production'

server '188.166.25.60',  user: 'deployer', roles: %w{app web db sidekiq}
