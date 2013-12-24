class AddIndexToBusinessOnCompanyNameAndCityAndAddress < ActiveRecord::Migration
  def change
    add_index :businesses, [:company_name, :city, :address]
  end
end
