require 'csv'
namespace :whenitopen do

  desc "Upload the businesses"
	task :upload_csv => :environment do
    file = "#{Rails.root}/lib/3to4.csv"
    CSV.foreach(file, headers: true) do |row|
      business = Business.new
      business.attributes = row.to_hash
      business.save!
    end
  end
  
  desc "Run the sphinx server"
  task :server => :environment do
    system("heroku run rake fs:rebuild")
  end
  
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
    Heroku::API.new(email: ENV['robertprsa10@gmail.com'], password: ENV['fur?56al'])
    post_ps_restart(ENV['whenitopen'])
  end
end