set :application, 'qwikwire_enterprise'
set :repo_url, 'git@github.com:Qwikwire/qwikwire_enterprise.git'
set :deploy_to, '/apps/qwikwire_enterprise'
# set :deploy_to, "/home/ubuntu/apps/qwikwire_enterprise"
set :log_level, :debug
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{tmp/sockets log config/puma public/qwikwire_enterprise}
set :sockets_path, Pathname.new("#{fetch(:deploy_to)}/shared/tmp/sockets/")

# These puma settings are only here because capistrano-puma is borked.
# See issue #4.
set :puma_roles, :app
set :puma_socket, "unix://#{fetch(:sockets_path).join('puma_' + fetch(:application) + '.sock')}"
set :pumactl_socket, "unix://#{fetch(:sockets_path).join('pumactl_' + fetch(:application) + '.sock')}"
set :puma_state, fetch(:sockets_path).join('puma.state') 
set :puma_log, -> { shared_path.join("log/puma-#{fetch(:stage )}.log") }
set :puma_flags, nil 

set :bundle_flags, '--deployment'

namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end

namespace :puma do
  desc "Restart puma instance for this application"
  task :restart do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{fetch(:puma_state)} restart"
      end
    end
  end

  desc "Show status of puma for this application"
  task :status do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{fetch(:puma_state)} stats"
      end
    end
  end

  desc "Show status of puma for all applications"
  task :overview do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec puma status"
      end
    end
  end
end