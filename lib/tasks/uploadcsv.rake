require 'csv'
require 'heroku-api'
namespace :whenitopen do

  desc "Upload the businesses"
	task :upload_csv => :environment do
    file = "#{Rails.root}/lib/8to9.csv"
    CSV.foreach(file, headers: true) do |row|
      @user = Business.new(
        :address => row[1],
        :city => row[2],
        :company_name => row[3],
        :contact_name => row[4],
        :employee => row[5],
        :fax_number => row[6],
        :gender => row[7],
        :major_division_description => row[8],
        :phone => row[9],
        :state => row[10],
        :sales => row[11],
        :sic_2_code_description => row[12],
        :sic_4_code=> row[13],
        :category=> row[14],
        :title=> row[15],
        :url=> row[16],
        :mon_from=> row[17],
        :mon_to=> row[18],
        :tue_from=> row[19],
        :tue_to=> row[20],
        :wed_from=> row[21],
        :wed_to=> row[22],
        :thu_from=> row[23],
        :thu_to=> row[24],
        :fri_from=> row[25],
        :fri_to=> row[26],
        :sat_from=> row[27],
        :sat_to=> row[28],
        :sun_from=> row[29],
        :sun_to=> row[30],
        :zip_code=> row[31],
        :longitude=> row[32],
        :latitude=> row[33]
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
