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
    @cities = Business.select('DISTINCT city,state').where("city like '#{params[:city]}%'")
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @cities = Business.select('DISTINCT name').where("name like '#{params[:name].split("'").first}%' and city = '#{session[:city]}'")
    respond_to do |format|
      format.js
    end
  end

  def search
    @ab_business_databases = Business.where("name like '#{params[:business][:name].split("'").first}%'").limit(1)
    if @ab_business_databases.empty?
      @spelling_suggestion = Business.search_spelling_suggestions(params[:business][:name].split("'").first)
    end
    a = Date.today.strftime("%a").downcase+"_to"
    @categories = Business.where("category = '#{@ab_business_databases.first.category.split("'").first}' and #{a} > '#{Time.now.strftime("%H").to_i - 12}' and address IS NOT NULL and city IS NOT NULL and id NOT IN (#{@ab_business_databases.first.id})").paginate :page => params[:category_page], :per_page => 9
  end
end
