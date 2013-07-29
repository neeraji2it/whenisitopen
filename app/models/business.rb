class Business < ActiveRecord::Base
  attr_accessible :address,:city,:contact_name,:company_name,:fax_number,:gender, :sales,:major_division_description, :sic_4_code,:sic_2_code_description, :employee, :title, :url, :phone, :state, :zip_code,:longitude,:latitude, :category,:gmaps, :mon_from, :mon_to, :tue_from, :tue_to, :wed_from, :wed_to, :thu_from, :thu_to, :fri_from, :fri_to, :sat_from, :sat_to, :sun_from, :sun_to 

  #  define_index do
  #    indexes comapny_name
  #  end
  
  def self.search_spelling_suggestions(query)
    #word = find_by_sql(["SELECT word, similarity(word, :term) AS sim FROM words WHERE word % :term and word <> :term order by sim desc limit 1",{:term=>term}]).first
    #      word = find_by_sql(["SELECT word, levenshtein_ratio(word, :term) AS sim FROM words where word != :term order by sim desc limit 1", {:term =>term}]).first
    word = Business.where("company_name sounds LIKE '#{query}'").limit(1)
    #word = find_by_sql(["SELECT keyword, levenshtein_ratio(keyword, :term) AS sim FROM keywords where keyword != :term order by sim desc limit 1", {:term =>term}]).first
    if word
      word
    end
    return word unless word == query
  end
end
