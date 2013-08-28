class ImportsController < ApplicationController
  before_filter :login?
  layout :get_layout
  def import
  end
  
  def index
    @per_page = params[:per_page] || 10
    @businesses = Business.where("company_name IS NOT NULL").paginate(:per_page => @per_page, :page => params[:page])
    @export_businesses = Business.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @export_businesses.to_csv }
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
end
