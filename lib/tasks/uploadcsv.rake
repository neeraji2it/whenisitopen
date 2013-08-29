require 'csv'
namespace :whenitopen do

  desc "Upload the businesses"
	task :upload_csv => :environment do
    file = "#{Rails.root}/lib/scrapper.csv"
    CSV.foreach(file, headers: true) do |row|
      business = Business.new
      business.attributes = row.to_hash
      business.save!
    end
  end
end