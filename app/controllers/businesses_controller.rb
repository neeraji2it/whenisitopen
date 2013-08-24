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
    @cities = Business.select('DISTINCT city,state').where("city ILIKE ?", "#{params[:city]}%") if Rails.env == 'production'
    @cities = Business.select('DISTINCT city,state').where("city LIKE ?", "#{params[:city]}%") if Rails.env == 'development'
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @name = params[:company_name].split('and').join('&')
    @cities = Business.select('DISTINCT company_name').where("company_name ILIKE ? and city = ?", "#{@name}%", "#{session[:city]}") if Rails.env == 'production'
    @cities = Business.select('DISTINCT company_name').where("company_name LIKE ? and city = ?", "#{@name}%", "#{session[:city]}") if Rails.env == 'development'
    respond_to do |format|
      format.js
    end
  end

  def search
    if params[:company_name].present?
      @name = params[:company_name].split('and').join('&')
      @ab_business_databases = Business.search "(*#{@name}*, *#{session[:city]}*)", :limit => 1 if Rails.env == 'production'
      @ab_business_databases = Business.search "(*#{@name}*, *#{session[:city]}*)", :limit => 1 if Rails.env == 'development'
      if @ab_business_databases.empty?
        @spelling_suggestion = Business.search_spelling_suggestions(params[:company_name], session[:city])
      else
        a = Date.today.strftime("%a").downcase+"_to"
        @nears = Business.near(@name,100, :order =>:distance)
        @all_categories = Business.where("category = ? and #{a} > '#{Time.now.strftime("%H").to_i - 12}' and address IS NOT NULL and city IS NOT NULL and address != ? and id NOT IN (?)", "#{@ab_business_databases.first.category}","#{@ab_business_databases.first.address}","#{@ab_business_databases.first.id}")
        @categorie_with_cond = @nears.where_values.reduce(:and)
        @categorie_with = @all_categories.where_values.reduce(:and)
        @categories = Business.where("(#{@categorie_with_cond}) and (#{@categorie_with})").paginate :page => params[:category_page], :per_page => 9
        @all_locations = Business.where("company_name = ? and address IS NOT NULL and city IS NOT NULL and address != ? and id NOT IN (?) and (mon_from IS NOT NULL and tue_from IS NOT NULL and wed_from IS NOT NULL and thu_from IS NOT NULL and fri_from IS NOT NULL and sat_from IS NOT NULL and sun_from IS NOT NULL)","#{@ab_business_databases.first.company_name}","#{@ab_business_databases.first.address}","#{@ab_business_databases.first.id}")
        @locations_with_cond = @nears.where_values.reduce(:and)
        @locations_with = @all_locations.where_values.reduce(:and)
        @locations = Business.where("(#{@locations_with_cond}) and (#{@locations_with})").paginate :page => params[:location_page], :per_page => 3
      end
    else
      redirect_to root_path
    end
  end
  
  def categorie_search
    @ab_business_databases = Business.search "(*#{params[:company_name]}*, *#{params[:city]}*, *#{params[:address]}*)", :limit => 1 if Rails.env == 'production'
    @ab_business_databases = Business.search "(*#{params[:company_name]}*, *#{params[:city]}*, *#{params[:address]}*)", :limit => 1 if Rails.env == 'development'
    a = Date.today.strftime("%a").downcase+"_to"
    @nears = Business.near(params[:company_name],100, :order =>:distance)
    @all_categories = Business.where("category = ? and #{a} > '#{Time.now.strftime("%H").to_i - 12}' and address IS NOT NULL and city IS NOT NULL and address != ? and id NOT IN (?)", "#{@ab_business_databases.first.category}","#{@ab_business_databases.first.address}","#{@ab_business_databases.first.id}")
    @categorie_with_cond = @nears.where_values.reduce(:and)
    @categorie_with = @all_categories.where_values.reduce(:and)
    @categories = Business.where("(#{@categorie_with_cond}) and (#{@categorie_with})").paginate :page => params[:category_page], :per_page => 9
    @all_locations = Business.where("company_name = ? and address IS NOT NULL and city IS NOT NULL and address != ? and id NOT IN (?) and (mon_from IS NOT NULL and tue_from IS NOT NULL and wed_from IS NOT NULL and thu_from IS NOT NULL and fri_from IS NOT NULL and sat_from IS NOT NULL and sun_from IS NOT NULL)", "#{@ab_business_databases.first.company_name}","#{@ab_business_databases.first.address}","#{@ab_business_databases.first.id}")
    @locations_with_cond = @nears.where_values.reduce(:and)
    @locations_with = @all_locations.where_values.reduce(:and)
    @locations = Business.where("(#{@locations_with_cond}) and (#{@locations_with})").paginate :page => params[:location_page], :per_page => 3
    render :action => 'search'
  end
  
  def edit
    @business = Business.find(params[:id])
  end
  
  def update
    @business = Business.find(params[:id])
    if @business.update_attributes(params[:business].reject{ |key, value| value.blank?} )
      redirect_to categorie_search_businesses_path('company_name' => @business.company_name, :city => @business.city, :address => @business.address)
    end
  end
end
