require 'csv'
namespace :whenitopen do

  desc "Send after two months of bussiness bid if customer didn't accept the bid. This will be sent after 2 months of bids "
	task :upload_csv => :environment do
    file = "#{Rails.root}/lib/c.csv"
    CSV.foreach(file, :row_sep => :auto, :col_sep => ";", :encoding => 'UTF-8') do |row|
      @business = Business.new({
          :company_name => row[0],
          :address => row[1],
          :city => row[2],
          :contact_name => row[3],
          :employee => row[4],
          :fax_number => row[5],
          :gender => row[6],
          :major_division_description => row[7],
          :phone => row[8],
          :state => row[9],
          :sales => row[10],
          :sic_2_code_description => row[11],
          :sic_4_code => row[12],
          :category => row[13],
          :title => row[14],
          :mon_from => row[15],
          :mon_to => row[16],
          :tue_from => row[17],
          :tue_to => row[18],
          :wed_from => row[19],
          :wed_to => row[20],
          :thu_from => row[21],
          :thu_to => row[22],
          :fri_from => row[23],
          :fri_to => row[24],
          :sat_from => row[25],
          :sat_to => row[26],
          :sun_from => row[27],
          :sun_to => row[28],
          :zip_code => row[29],
          :longitude => row[31],
          :latitude => row[32]
        })
      @business.save if !(Business.exists?(:city => row[2]) and Business.exists?(:address => row[1]) and Business.exists?(:company_name => row[0]))
    end
  end
end