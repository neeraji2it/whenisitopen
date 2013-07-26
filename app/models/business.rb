class Business < ActiveRecord::Base
  attr_accessible :name,:url,:address,:city,:state,:zip_code,:phone,:longitude,:latitude,:category,:mon_from,:mon_to,:tue_from,:tue_to,:wed_from,:wed_to,:thu_from,:thu_to,:fri_from,:fri_to,:sat_from,:sat_to,:sun_from,:sun_to

  #  define_index do
  #    indexes name
  #    indexes city
  #  end

  def self.search_spelling_suggestions(query)
    #word = find_by_sql(["SELECT word, similarity(word, :term) AS sim FROM words WHERE word % :term and word <> :term order by sim desc limit 1",{:term=>term}]).first
    #      word = find_by_sql(["SELECT word, levenshtein_ratio(word, :term) AS sim FROM words where word != :term order by sim desc limit 1", {:term =>term}]).first
    word = Business.where("name sounds LIKE '#{query}'").limit(1)
    #word = find_by_sql(["SELECT keyword, levenshtein_ratio(keyword, :term) AS sim FROM keywords where keyword != :term order by sim desc limit 1", {:term =>term}]).first
    if word
      word
    end
    return word unless word == query
  end
end
