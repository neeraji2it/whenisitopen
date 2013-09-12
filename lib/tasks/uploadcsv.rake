require 'csv'
require 'heroku-api'
namespace :whenitopen do

  desc "Upload the businesses"
	task :upload_csv => :environment do
    file = "#{Rails.root}/lib/timies.csv"
    CSV.foreach(file, :headers => true) do |row|
      @user = Business.new(
        :address => row[0],
        :city => row[1],
        :company_name => row[2],
        :phone => row[3],
        :state => row[4],
        :mon_from=> row[5],
        :mon_to=> row[6],
        :tue_from=> row[7],
        :tue_to=> row[8],
        :wed_from=> row[9],
        :wed_to=> row[10],
        :thu_from=> row[11],
        :thu_to=> row[12],
        :fri_from=> row[13],
        :fri_to=> row[14],
        :sat_from=> row[15],
        :sat_to=> row[16],
        :sun_from=> row[17],
        :sun_to=> row[18],
        :zip_code=> row[19],
        :longitude=> row[20],
        :latitude=> row[21]
      )
      @user.save!
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
