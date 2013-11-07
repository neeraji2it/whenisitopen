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
  
  def new
    @business = Business.new
  end
  
  def create
    @business = Business.new(params[:business].reject{ |key, value| value.blank?})
    if @business.save
      @business.update_attribute(:status, 'pending') if !current_admin
      redirect_to imports_path
    end
  end

  def cities
    @cities = Business.select('DISTINCT city,state').where("city LIKE ?", "#{params[:city]}%") 
    respond_to do |format|
      format.js
    end
  end

  def city_businesses
    @name = params[:company_name].split(' and').join(' &')
    @cities = Business.select('DISTINCT company_name').where("address IS NOT NULL and company_name LIKE ? and city = ?", "#{@name}%", "#{session[:city]}") 
    respond_to do |format|
      format.js
    end
  end

  def search
    if params[:company_name].present?
      @name = params[:company_name].split(' and').join(' &')
      a = Time.zone.now.strftime("%a").downcase+"_to"
      @ab_business_databases = Business.search "(*#{@name}*, *#{session[:city]}*)", :limit => 1 
      if @ab_business_databases.empty?
        @spelling_suggestion = Business.search_spelling_suggestions(@name, session[:city])
      else
        @lat = @ab_business_databases.first.latitude
        @lng = @ab_business_databases.first.longitude
        @categories = Business.near([@lat, @lng],20000, :order =>:distance).where("category = ? and company_name != ? and #{a} > #{Time.zone.now.strftime("%H").to_i - 12} and address IS NOT NULL and city IS NOT NULL and address != ? and id NOT IN (?)", "#{@ab_business_databases.first.category}", "#{@ab_business_databases.first.company_name}","#{@ab_business_databases.first.address}","#{@ab_business_databases.first.id}").paginate :page => params[:category_page], :per_page => 9
        @locations = Business.near([@lat, @lng],20000, :order =>:distance).where("company_name = ? and id NOT IN (?)", "#{@ab_business_databases.first.company_name}", "#{@ab_business_databases.first.id}").paginate :page => params[:location_page], :per_page => 3
      end
    else
      redirect_to root_path
    end
  end
  
  def categorie_search
    a = Time.zone.now.strftime("%a").downcase+"_to"
    @ab_business_databases = Business.search "(#{params[:company_name]}*, #{params[:city]}*, #{params[:address]}*)", :limit => 1 
    @lat = @ab_business_databases.first.latitude
    @lng = @ab_business_databases.first.longitude
    @categories = Business.near([@lat, @lng],20000, :order =>:distance).where("category = ? and company_name != ? and #{a} > #{Time.zone.now.strftime("%H").to_i - 12} and address IS NOT NULL and city IS NOT NULL and address != ? and id NOT IN (?)", "#{@ab_business_databases.first.category}", "#{@ab_business_databases.first.company_name}","#{@ab_business_databases.first.address}","#{@ab_business_databases.first.id}").paginate :page => params[:category_page], :per_page => 9
    @locations = Business.near([@lat, @lng],20000, :order =>:distance).where("company_name = ? and id NOT IN (?)", "#{@ab_business_databases.first.company_name}", "#{@ab_business_databases.first.id}").paginate :page => params[:location_page], :per_page => 3
    render :action => 'search'
  end
  
  def edit
    @business = Business.find(params[:id])
  end
  
  def update
    @business = Business.find(params[:id])
    if @business.update_attributes(params[:business].reject{ |key, value| value.blank?} )
      @business.update_attribute(:status, 'pending') if !current_admin
      redirect_to edit_business_path(@business)
    end
  end
  
  def pending_businesses
    @businesses = Business.where("status = 'pending'")
  end
  
  def confirm_business
    @business = Business.find(params[:id])
    @admin = Admin.first
    sign_in(:admin,@admin,:bypass => true)
    if params[:status] == 'accept'
      @business.update_attribute(:status, 'confirmed') if current_admin
    else
      @business.update_attribute(:status, 'rejected') if current_admin
    end
    redirect_to imports_path
  end
  
  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    @admin = Admin.first
    sign_in(:admin,@admin,:bypass => true)
    redirect_to imports_path
  end
end
