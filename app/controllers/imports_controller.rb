class ImportsController < ApplicationController
  before_filter :login?
  layout :get_layout
  def import
    @title="Import Users"
  end
  
  def index
    @products = Business.order(:id)
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
    end
  end

  def upload_xls
    @title="Import Users"
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
