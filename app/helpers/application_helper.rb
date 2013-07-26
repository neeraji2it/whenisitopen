module ApplicationHelper
  
  def datee(ccategory)
    @date = Date.today.strftime("%a").downcase
    if @date == 'mon'
      ccategory.mon_to.to_i
    elsif @date == 'tue'
      ccategory.tue_to.to_i
    elsif @date == 'wed'
      ccategory.wed_to.to_i
    elsif @date == 'thu'
      ccategory.thu_to.to_i
    elsif @date == 'fri'
      ccategory.fri_to.to_i
    elsif @date == 'sat'
      ccategory.sat_to.to_i
    else
      ccategory.sun_to.to_i
    end
  end
end
