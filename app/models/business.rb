class Business < ActiveRecord::Base
  attr_accessible :address,:city,:contact_name,:company_name,:fax_number,:gender, :sales,:major_division_description, :sic_4_code,:sic_2_code_description, :employee, :title, :url, :phone, :state, :zip_code,:longitude,:latitude, :category,:gmaps, :mon_from, :mon_to, :tue_from, :tue_to, :wed_from, :wed_to, :thu_from, :thu_to, :fri_from, :fri_to, :sat_from, :sat_to, :sun_from, :sun_to 
  geocoded_by :address
  define_index do
    indexes company_name
    indexes city
    indexes state
    indexes address
    set_property :enable_star => true
  end
  
  def self.search_spelling_suggestions(query,city)
    word = Business.where("company_name ILIKE ? and city ILIKE ?", "#{query.slice(0..2)}%", "#{city}%").limit(1) if Rails.env == 'production'
    word = Business.where("company_name sounds LIKE ? and city sounds LIKE ?","#{query}%","#{city}%").limit(1) if Rails.env == 'development'
    if word
      word
    end
    return word.first.company_name unless word == query
  end
end
