class BusinessesController < ApplicationController
  autocomplete :business, :name
  layout :get_layout
  def index
    if params[:city]
      session[:city] = params[:city]
      session[:state] = params[:state]
    end
    session[:state]
    if request.xhr?
      respond_to do |format|
        format.js
      end
    end
  end

  def cities
    @cities = Business.select('DISTINCT city,state').where("city ILIKE '#{params[:city]}%'").limit(10)
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @cities = Business.select('DISTINCT name').where("name ILIKE '#{params[:name].split("'").first}%' and city = '#{session[:city]}'")
    respond_to do |format|
      format.js
    end
  end

  def search
    @ab_business_databases = Business.where("name ILIKE '#{params[:business][:name].split("'").first}%'").limit(1)
    if @ab_business_databases.empty?
      @spelling_suggestion = Business.search_spelling_suggestions(params[:business][:name].split("'").first)
    end

    for ccategory in @ab_business_databases
      @date = Date.today.strftime("%a").downcase
      @categories = Business.where("category = '#{ccategory.category.split("'").first}' and address IS NOT NULL and city IS NOT NULL and id NOT IN (#{@ab_business_databases.first.id})").paginate :page => params[:category_page], :per_page => 9
    end
  end
end
