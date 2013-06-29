require 'spreadsheet'
require 'csv'
class ImportsController < ApplicationController
  layout :get_layout, :only => ['upload_xls']
  def import
    @title="Import Users"
  end

  def upload_xls
    @title="Import Users"
    if request.post?
      CSV.parse(params[:file].read) do |row|
        row = row.collect(&:to_s).collect(&:strip).collect{|s| s.gsub("\"", "")}
        # row = row[0].to_s.split("\t").collect(&:strip)
        Business.create({
            :name=>row[1],
            :url=>row[2],
            :address=>row[3],
            :city=>row[4],
            :state=>row[5],
            :zip_code=>row[6],
            :phone=>row[7],
            :longitude=>row[8],
            :latitude=>row[9],
            :category=>row[10]
          })
      end

      flash[:notice] = "Uploading completed."
      redirect_to root_path
    else
      render :layout => false
    end
  end
end
