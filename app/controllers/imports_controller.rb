class ImportsController < ApplicationController
  before_filter :login?
  layout :get_layout
  
  def import
    
  end
  
  def index
    @per_page = params[:per_page] || 10
    @businesses = Business.where("company_name IS NOT NULL and address IS NOT NULL and (status IS NULL or status = 'confirmed')").order('id Desc').paginate(:per_page => @per_page, :page => params[:page])
    @export_businesses = Business.where("company_name IS NOT NULL").limit(100000)
    respond_to do |format|
      format.html
      format.csv {send_data @export_businesses.to_csv, :filename => "Businesses.csv"}
    end
  end
  
  def delete_business
    
  end
  
  def delete_all_by_business_name
    @businesses = Business.where("company_name = ?", "#{params[:company_name]}")
    @businesses.destroy_all
    redirect_to imports_path
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
end
