class ImportsController < ApplicationController
  before_filter :login?
  layout :get_layout
  def import
    @title="Import Users"
  end
  
  def index
    @products = Business.order(:company_name)
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
    end
  end

  def upload_xls
    @title="Import Users"
    if request.post?
      CSV.parse(params[:file].read) do |row|
        row = row.collect(&:to_s).collect(&:strip).collect{|s| s.gsub("\"", "")}
        @business = Business.new(
          :address => row[1],
          :city => row[2],
          :contact_name => row[3],
          :company_name => row[4],
          :fax_number => row[5],
          :gender => row[6],
          :sales => row[7],
          :major_division_description => row[8],
          :sic_4_code => row[9],
          :sic_2_code_description => row[10],
          :employee => row[11],
          :title => row[12],
          :url => row[13],
          :phone => row[14],
          :state => row[15],
          :zip_code => row[16],
          :longitude => row[17],
          :latitude => row[18],
          :category => row[19],
          :mon_from => row[21],
          :mon_to => row[22],
          :tue_from => row[23],
          :tue_to => row[24],
          :wed_from => row[25],
          :wed_to => row[26],
          :thu_from => row[27],
          :thu_to => row[28],
          :fri_from => row[29],
          :fri_to => row[30],
          :sat_from => row[31],
          :sat_to => row[32],
          :sun_from => row[33],
          :sun_to => row[34]
        )
        @business.save if !(Business.exists?(:city => row[2]) and Business.exists?(:address => row[1]) and Business.exists?(:company_name => row[0]))
      end
      flash[:notice] = "Uploading completed."
      redirect_to imports_path
    else
      flash[:error] = "Failed to Upload a file"
      render :action => 'import'
    end
  end
end
