require 'csv'
namespace :whenitopen do

  desc "Upload the businesses"
	task :upload_csv => :environment do
    file = "#{Rails.root}/lib/f.csv"
    CSV.foreach(file, headers: true) do |row|
      business = Business.find_by_id(row[0]) || Business.new
      business.attributes = row.to_hash
      business.save!
    end
  end
end