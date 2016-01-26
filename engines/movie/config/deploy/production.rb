# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role

#set :application, 'magtuner-rails-staging'
#set :deploy_to, '/var/www/magtuner-rails-staging'

SERVER = "91.221.70.59"
role :app, [SERVER] 
role :web, [SERVER] 

server SERVER, user: 'deploy', roles: %w{web app}

set :ssh_options, {
    forward_agent: true
}
