class BusinessesController < ApplicationController
  autocomplete :business, :name
  layout :get_layout
  def index
    if params[:city]
      session[:city] = params[:city]
      session[:state] = params[:state]
    end
    puts session[:state]
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def cities
    @cities = Business.select('DISTINCT city,state').where("city LIKE '#{params[:city]}%'")
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @cities = Business.select('DISTINCT name').where("name LIKE '#{params[:name].split("'").first}%' and city = '#{session[:city]}'")
    respond_to do |format|
      format.js
    end
  end

  def search
    @ab_business_databases = Business.where("name LIKE '#{params[:business][:name].split("'").first}%'").limit(1)

    for ccategory in @ab_business_databases
      @categories = Business.where("name = '#{ccategory.name.split("'").first}}' and id NOT IN (#{@ab_business_databases.first.id})").paginate :page => params[:category_page], :per_page => 9
    end
  end
end
