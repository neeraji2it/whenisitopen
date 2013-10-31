class Business < ActiveRecord::Base
  attr_accessible :address,:city,:contact_name,:company_name,:fax_number,:gender, :sales,:major_division_description, :sic_4_code,:sic_2_code_description, :employee, :title, :url, :phone, :state, :zip_code,:longitude,:latitude, :category,:gmaps, :mon_from, :mon_to, :tue_from, :tue_to, :wed_from, :wed_to, :thu_from, :thu_to, :fri_from, :fri_to, :sat_from, :sat_to, :sun_from, :sun_to, :mon_closed,:tue_closed,:wed_closed,:thu_closed,:fri_closed,:sat_closed,:sun_closed, :status, :id, :created_at, :updated_at
  geocoded_by :address
  define_index do
    indexes company_name
    indexes city
    indexes id
    indexes state
    indexes address
    has :latitude,:longitude
    set_property :enable_star => true
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names[1..-1]
      all.each do |business|
        csv << business.attributes.values_at(*column_names[1..-1])
      end
    end
  end
  
  def to_param
    "#{self.id}-#{self.company_name.to_s.parameterize}"
  end
  
  def self.search_spelling_suggestions(query,city)
    word = Business.where("company_name LIKE ? and city sounds LIKE ?","%#{query.slice(0..2)}%","#{city}%").limit(1)
    if word
      word
    end
    return word.first.company_name unless word == query
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: 'UTF-8') do |row|
      business = find_by_city_and_company_name_and_address(row[1],row[2],row[0]) || new
      business.attributes = row.to_hash.slice(*accessible_attributes)
      business.save!
    end
  end
end
