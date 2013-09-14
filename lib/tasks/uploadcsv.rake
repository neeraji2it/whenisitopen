require 'csv'
require 'heroku-api'
namespace :whenitopen do

  desc "Restart app by process and time table"
  task :restart => :environment do
    time_hash = {
      1 => %w[web.1 web.2 web.3],
      3 => %w[web.4 web.5 web.6],
      5 => %w[web.7 web.8 web.9],
      7 => %w[web.10 web.11 web.12],
      16 => %w[web.13 web.14 web.1],
      18 => %w[web.2 web.3 web.4],
      20 => %w[web.5 web.6 web.7],
      22 => %w[web.8 web.9 web.10],
      0 => %w[web.11 web.12 web.13 web.14],
    }
    processes = time_hash[Time.now.hour]
    processes.each {|process| restart_process(process)} if processes
  end

  def restart_process(name)
    puts "restarting process #{name}:"
    heroku = Heroku::API.new('e7b6434e-8977-4e1f-9174-1c84c75fc4a5')
    heroku.ps_restart(ENV['APP_NAME'], :ps => name)
  end
end