class BusinessesController < ApplicationController
  autocomplete :business, :name
  layout :get_layout
  def index
    if params[:city]
      session[:city] = params[:city]
    end
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def cities
    @cities = Business.select('DISTINCT city').where("city like '#{params[:city]}%'")
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @cities = Business.select('DISTINCT name').where("name like '#{params[:name]}%' and city = '#{session[:city]}'")
    respond_to do |format|
      format.js
    end
  end

  def search
    puts params[:business][:name]
    @ab_business_databases = Business.where("name = '#{params[:business][:name]}'").limit(1)
    for ccategory in @ab_business_databases
      @categories = Business.where("category = '#{ccategory.category}'").paginate :page => params[:category_page], :per_page => 9
    end
  end
end
