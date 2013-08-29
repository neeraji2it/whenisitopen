class CreatePendingScrappers < ActiveRecord::Migration
  def change
    create_table :pending_scrappers do |t|
      t.string :address
      t.string :city
      t.string :company_name
      t.string :contact_name
      t.string :employee
      t.string :fax_number
      t.string :gender
      t.text :major_division_description
      t.string :phone
      t.string :state
      t.string :sales
      t.text :sic_2_code_description
      t.string :sic_4_code
      t.string :category
      t.string :title
      t.string :url
      t.string :mon_from
      t.string :mon_to
      t.string :tue_from
      t.string :tue_to
      t.string :wed_from
      t.string :wed_to
      t.string :thu_from
      t.string :thu_to
      t.string :fri_from
      t.string :fri_to
      t.string :sat_from
      t.string :sat_to
      t.string :sun_from
      t.string :sun_to
      t.string :zip_code
      t.float :longitude
      t.float :latitude
      t.string :mon_closed
      t.string :tue_closed
      t.string :wed_closed
      t.string :thu_closed
      t.string :fri_closed
      t.string :sat_closed
      t.string :sun_closed
      t.boolean :gmaps
      t.timestamps
    end
  end
end
