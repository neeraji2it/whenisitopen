require 'csv'
namespace :whenitopen do

  desc "Send after two months of bussiness bid if customer didn't accept the bid. This will be sent after 2 months of bids "
	task :upload_csv => :environment do
    
    file = "#{Rails.root}/lib/user_record.csv"
    CSV.foreach(file, :headers => true, :encoding => 'UTF-8') do |row|
      Business.create({
          :address => row[0],
          :city => row[1],
          :name => row[2],
          :url => row[3],
          :phone => row[4],
          :state => row[5],
          :zip_code => row[6],
          :longitude => row[7],
          :latitude => row[8],
          :category => row[9],
          :mon_from => row[10],
          :mon_to => row[11],
          :tue_from => row[12],
          :tue_to => row[13],
          :wed_from => row[14],
          :wed_to => row[15],
          :thur_from => row[16],
          :thur_to => row[17],
          :fri_from => row[18],
          :fri_to => row[19],
          :sat_from => row[20],
          :sat_to => row[21],
          :sun_from => row[22],
          :sun_to => row[23]
        })
    end
  end
end