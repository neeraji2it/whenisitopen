class BusinessesController < ApplicationController
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
    @cities = Business.select('DISTINCT city,state').where("city ILIKE '#{params[:city]}%'") if Rails.env == 'production'
    @cities = Business.select('DISTINCT city,state').where("city LIKE '#{params[:city]}%'") if Rails.env == 'development'
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @cities = Business.select('DISTINCT company_name').where("company_name ILIKE '#{params[:company_name]}%' and city = '#{session[:city]}'") if Rails.env == 'production'
    @cities = Business.select('DISTINCT company_name').where("company_name LIKE '#{params[:company_name]}%' and city = '#{session[:city]}'") if Rails.env == 'development'
    respond_to do |format|
      format.js
    end
  end

  def search
    @ab_business_databases = Business.where("company_name ILIKE '#{params[:business][:company_name]}%'").limit(1) if Rails.env == 'production'
    @ab_business_databases = Business.where("company_name LIKE '#{params[:business][:company_name]}%'").limit(1) if Rails.env == 'development'
    if @ab_business_databases.empty?
      @spelling_suggestion = Business.search_spelling_suggestions(params[:business][:company_name].split("'").first)
    end
    a = Date.today.strftime("%a").downcase+"_to"
    @categories = Business.where("company_name = '#{@ab_business_databases.first.company_name.split("'").first}' and #{a} > '#{Time.now.strftime("%H").to_i - 12}' and address IS NOT NULL and city IS NOT NULL and id NOT IN (#{@ab_business_databases.first.id})").paginate :page => params[:category_page], :per_page => 9
  end
end
