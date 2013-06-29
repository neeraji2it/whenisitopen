class Business < ActiveRecord::Base
  attr_accessible :name,:url,:address,:city,:state,:zip_code,:phone,:longitude,:latitude,:category,:mon_from,:mon_to,:tue_from,:tue_to,:wed_from,:wed_to,:thur_from,:thur_to,:fri_from,:fri_to,:sat_from,:sat_to,:sun_from,:sun_to

#  define_index do
#    indexes name
#    indexes city
#  end
end
