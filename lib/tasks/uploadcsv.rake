require 'csv'
require 'heroku-api'
namespace :whenitopen do
  desc "Update the existing database through csv file"
  task :upload_csv => :environment do
    files = ["#{Rails.root}/lib/Business.csv","#{Rails.root}/lib/0to1.csv","#{Rails.root}/lib/10to11.csv","#{Rails.root}/lib/1to2.csv","#{Rails.root}/lib/4to5.csv","#{Rails.root}/lib/5to6.csv","#{Rails.root}/lib/6to7.csv","#{Rails.root}/lib/7to8.csv","#{Rails.root}/lib/8to9.csv","#{Rails.root}/lib/9to10.csv"]
    for file in files
      CSV.foreach(file, headers: true) do |row|
        begin
        business = Business.find_by_city_and_company_name_and_address(row[1],row[2],row[0]) || Business.new
        business.attributes = row.to_hash
        puts business.address
        business.save!
        rescue => e
          puts e.message
        end
      end
    end
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
    heroku = Heroku::API.new(:api_key => 'e7b6434e-8977-4e1f-9174-1c84c75fc4a5')
    heroku.post_ps_scale(ENV['APP_NAME'], 'web', 2)
  end
end
