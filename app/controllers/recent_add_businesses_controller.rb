class RecentAddBusinessesController < ApplicationController
  def index
    @recent_businesses = RecentAddBusiness.paginate :page => params[:recent_page], :per_page => 10
  end
  
  def new
    @recent_business = RecentAddBusiness.new
  end
  
  def create
    @recent_business = RecentAddBusiness.new(params[:recent_add_business])
    if @recent_business.save
      respond_to do |format|
        format.js
      end
    end
  end
  
  def edit
    @recent_business = RecentAddBusiness.find(params[:id])
  end
  
  def update
    @recent_business = RecentAddBusiness.find(params[:id])
    if @recent_business.update_attributes(params[:recent_add_business])
      respond_to do |format|
        format.js
      end
    end
  end
  
  def destroy
    @recent_business = RecentAddBusiness.find(params[:id])
    @recent_business.destroy
    @admin = Admin.first
    sign_in(:admin,@admin,:bypass => true)
    redirect_to recent_add_businesses_path
  end
end
