module ApplicationHelper
  
  def datee(ccategory)
    @date = Date.today.strftime("%a").downcase
    if @date == 'mon'
      ccategory.mon_to.split(":").first.to_i
    elsif @date == 'tue'
      ccategory.tue_to.split(":").first.to_i
    elsif @date == 'wed'
      ccategory.wed_to.split(":").first.to_i
    elsif @date == 'thu'
      ccategory.thu_to.split(":").first.to_i
    elsif @date == 'fri'
      ccategory.fri_to.split(":").first.to_i
    elsif @date == 'sat'
      ccategory.sat_to.split(":").first.to_i
    else
      ccategory.sun_to.split(":").first.to_i
    end
  end
end
