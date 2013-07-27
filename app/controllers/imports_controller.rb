require 'spreadsheet'
require 'csv'
class ImportsController < ApplicationController
  layout :get_layout
  def import
    @title="Import Users"
  end

  def upload_xls
    @title="Import Users"
    if params[:file].present?
      if request.post?
        CSV.parse(params[:file].read) do |row|
          row = row.collect(&:to_s).collect(&:strip).collect{|s| s.gsub("\"", "")}
          # row = row[0].to_s.split("\t").collect(&:strip)
          Business.create({
              :address => row[0],
              :city => row[1],
              :name => row[2],
              :url => row[3],
              :phone => row[4],
              :state => row[5],
              :zip_code => row[6],
              :longitude => row[7],
              :latitude => row[8],
              :category => row[9],
              :mon_from => row[10],
              :mon_to => row[11],
              :tue_from => row[12],
              :tue_to => row[13],
              :wed_from => row[14],
              :wed_to => row[15],
              :thu_from => row[16],
              :thu_to => row[17],
              :fri_from => row[18],
              :fri_to => row[19],
              :sat_from => row[20],
              :sat_to => row[21],
              :sun_from => row[22],
              :sun_to => row[23]
            })
        end
        flash[:notice] = "Uploading completed."
        redirect_to import_imports_path
      else
        render :layout => false
      end
    else
      flash[:error] = "Failed to Upload a file"
      render :action => 'import'
    end
  end
end
