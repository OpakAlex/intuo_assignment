SSHKit.config.command_map[:rake] = "bundle exec rake"

lock '3.4.0'
set :rails_env, fetch(:stage)
set :migration_role, 'app'
set :application, 'intuo_assignment'
set :repo_url, 'git@github.com:OpakAlex/intuo_assignment.git'

set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, "/var/www/intuo_assignment-#{fetch(:stage)}"
set :rbenv_ruby, '2.2.1'

# Default value for :pty is false
# set :pty, true

# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'pids', 'public/uploads')

set :whenever_roles, ->{ :app }
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finished, :restart_rpush do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # execute :bundle, :exec, "rpush stop -e #{fetch(:rails_env)}"
          # execute :bundle, :exec, "rpush start -e #{fetch(:rails_env)}"
        end
      end
    end
  end
end

after  'deploy:publishing',          'deploy:restart'

namespace :unicorn do
  pid_path = "#{release_path}/pids"
  unicorn_pid = "#{pid_path}/unicorn.pid"

  def run_unicorn
    within release_path do
      execute :bundle, "exec unicorn -c #{release_path}/config/unicorn/#{fetch(:stage)}.rb -D -E #{fetch(:stage)}"
    end
  end

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      run_unicorn
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-QUIT `cat #{unicorn_pid}`"
      end
    end
  end

  desc 'Force stop unicorn (kill -9)'
  task :force_stop do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-9 `cat #{unicorn_pid}`"
        execute :rm, unicorn_pid
      end
    end
  end

  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      if test "[ -f #{unicorn_pid} ]"
        execute :kill, "-USR2 `cat #{unicorn_pid}`"
      else
        run_unicorn
      end
    end
  end
end
