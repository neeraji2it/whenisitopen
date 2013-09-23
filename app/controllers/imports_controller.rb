require 'nokogiri'
require 'open-uri'
require 'rubygems'
class ImportsController < ApplicationController
  before_filter :login?, :except => ['scraptiming']
  layout :get_layout
  def import
  end
  
  def index
    @per_page = params[:per_page] || 10
    @businesses = Business.where("company_name IS NOT NULL and address IS NOT NULL").order('id Desc').paginate(:per_page => @per_page, :page => params[:page])
    @export_businesses = Business.order(:id).limit(25000)
    respond_to do |format|
      format.html
      format.csv {send_data @export_businesses.to_csv, :filename => "Businesses.csv"}
    end
  end

  def upload_xls
    if request.post?
      Business.import(params[:file])
      flash[:notice] = "Uploading completed."
      redirect_to imports_path
    else
      flash[:error] = "Failed to Upload a file"
      render :action => 'import'
    end
  end
  
  def scraptiming
    @companies= Business.limit(100).offset(10)
    @companies.each do |business|
      # url = "http://www.yelp.com/search?find_desc=#{business.split(' ').join('+')}&find_loc=Edmonton%2C+AB&ns=1"
      url = "http://www.yelp.com/search?find_desc=#{business.company_name.split(' ').join('+')}&find_loc=#{business.city.split(' ').join('+')}%2C+#{business.state}&ns=1"
      data = Nokogiri::HTML(open(url,'User-Agent' => 'ruby'))
      concerts = data.css('ul.ylist.ylist-bordered.search-results li')

      if concerts.empty? != true
        concerts.each do |concert|
          link = concert.css('div.search-result.natural-search-result.biz-listing-large').css('div.clearfix.media-block.main-attributes').css('div.media-story').css("h3.search-result-title span a.biz-name")[0] != nil ? concert.css('div.search-result.natural-search-result.biz-listing-large').css('div.clearfix.media-block.main-attributes').css('div.media-story').css("h3.search-result-title span a.biz-name")[0]["href"] : nil
          #      puts concert.css('div').css('div.secondary-attributes').css('span.biz-phone').text
          if link != nil
            url1 = "http://www.yelp.com/"+link

            data1 = Nokogiri::HTML(open(url1,'User-Agent' => 'ruby'))
            concerts1 = data1.css('div#bizBox')
            if concerts1.css("div#bizInfoBody div.wrap").css('div#bizInfoHeader h1').text.strip.downcase.scan("#{business.company_name.downcase}").empty? != true
              if (business.state == (concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[2] != nil ? concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[2].text : '0') and (business.city.downcase == (concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[1] != nil ? concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[1].text.downcase : '0')) and (business.zip_code == (concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[3] != nil ? concerts1.css("div#bizInfoBody div#bizInfoContent").css('address span')[3].text.split(' ').join('') : '0')))
                concerts1.each do |concert|
                  url = concert.css("div#bizInfoBody div#bizInfoContent").css('div#bizUrl a').text if concert.css("div#bizInfoBody div#bizInfoContent").css('div#bizUrl')[0] != nil
                  if !Business.exists?(:company_name => business.company_name,:zip_code => business.state)
                    @lat_bus = Business.find(business.id)
                    #@lat_bus = ScrapBusiness.new(:address =>address,:city => city,:company_name => c_name,:categories => cate,:phone_no =>ph_no,:province => provience,:zipcode => postalcode,:url => url)
                    @lat_bus.update_attributes(business.attributes) if business.gmaps != true
                    concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').empty?
                    if concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').empty? == false
                      concert.css('div#bizAdditionalInfo dl dd.attr-BusinessHours p.hours').each do |h|
                        h.text.split(', ').count
                        if h.text.split(', ').count != 2
                          if h.text.split(' ', 2)[0].split('-').count > 1
                            array = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                            i = array.index("#{h.text.split(' ', 2)[0].split('-')[0]}")
                            j = array.index("#{h.text.split(' ', 2)[0].split('-')[1]}")
                            if h.text.split(' ', 2)[1].split('-')[0].split(':').count > 1
                              from =  h.text.split(' ', 2)[1].split('-')[0].split(' ').join('')
                            else
                              from = h.text.split(' ', 2)[1].split('-')[0].split(' ').join(':00')
                            end
                            if h.text.split(' ', 2)[1].split('-')[1].split(':').count > 1
                              to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                            else
                              to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                            end
                            array[i..j].each do |day|
                              day1 = day.downcase+"_from"
                              day2 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                            end
                          else
                            day = h.text.split(' ', 2)[0]
                            if h.text.split(' ', 2)[1].split('-')[0].split(':').count > 1
                              from1 =  h.text.split(' ', 2)[1].split('-')[0].split(' ').join('')
                            else
                              from1 = h.text.split(' ', 2)[1].split('-')[0].split(' ').join(':00')
                            end
                            if h.text.split(' ', 2)[1].split('-')[1].split(':').count > 1
                              to1 = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                            else
                              to1 = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                            end
                            day1 = day.downcase+"_from"
                            day2 = day.downcase+"_to"
                            @lat_bus.update_attributes("#{day1.split(",").join('')}" => from1,"#{day2.split(",").join('')}" => to1)
                          end
                        else
                          array = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                          if h.text.split(', ',2)[1].split(" ",2).last.split('-')[0].split(':').count > 1
                            from =  h.text.split(' ', 2)[1].split(" ",2).last.split('-')[0].split(' ').join('')
                          else
                            from = h.text.split(' ', 2)[1].split(" ",2).last.split('-')[0].split(' ').join(':00')
                          end
                          if h.text.split(', ')[1].split(" ",2).last.split('-')[1].split(':').count > 1
                            to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join('')
                          else
                            to = h.text.split(' ', 2)[1].split('-')[1].split(' ').join(':00')
                          end
                          if h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                            i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                            j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                            array[i..j].each do |day|
                              day1 = day.downcase+"_from"
                              day2 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                            end

                            k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                            l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                            array[k..l].each do |day|
                              day3 = day.downcase+"_from"
                              day4 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                            end
                          elsif h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count != 2
                            i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                            j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                            array[i..j].each do |day|
                              day1 = day.downcase+"_from"
                              day2 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                            end

                            day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                            day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                            @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                          elsif h.text.split(', ',2)[0].split("-").count != 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                            k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                            l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                            array[k..l].each do |day|
                              day1 = day.downcase+"_from"
                              day2 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                            end

                          elsif h.text.split(', ',2)[0].split("-").count == 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count != 2
                            i = array.index("#{h.text.split(', ',2)[0].split("-")[0]}")
                            j = array.index("#{h.text.split(', ',2)[0].split("-")[1]}")
                            array[i..j].each do |day|
                              day1 = day.downcase+"_from"
                              day2 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                            end

                            day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                            day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                            @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                          elsif h.text.split(', ',2)[0].split("-").count != 2 and h.text.split(', ')[1].split(" ",2).first.split("-").count == 2
                            k = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[0]}")
                            l = array.index("#{h.text.split(', ')[1].split(" ",2).first.split("-")[1]}")
                            array[k..l].each do |day|
                              day1 = day.downcase+"_from"
                              day2 = day.downcase+"_to"
                              @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to)
                            end

                            day3 = h.text.split(', ',2)[0].downcase+"_from"
                            day4 = h.text.split(', ',2)[0].downcase+"_to"
                            @lat_bus.update_attributes("#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                          else h.text.split(', ',2)[1].split("-").count != 2
                            day1 = h.text.split(', ',2)[0].downcase+"_from"
                            day2 = h.text.split(', ',2)[0].downcase+"_to"
                            day3 = h.text.split(', ')[1].split(" ",2).first.downcase+"_from"
                            day4 = h.text.split(', ')[1].split(" ",2).first.downcase+"_to"
                            @lat_bus.update_attributes("#{day1.split(",").join('')}" => from,"#{day2.split(",").join('')}" => to,"#{day3.split(",").join('')}" => from,"#{day4.split(",").join('')}" => to)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      business.update_attribute(:gmaps, true)
      puts business.company_name
    end
    redirect_to '/'
  end
end
