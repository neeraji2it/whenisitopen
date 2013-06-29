class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table(:businesses) do |t|
      t.string :address
      t.string :city
      t.string :name
      t.string :url
      t.string :phone
      t.string :state
      t.string :zip_code
      t.float :longitude
      t.float :latitude
      t.string :category
      t.boolean :gmaps
      t.string :mon_from
      t.string :mon_to
      t.string :tue_from
      t.string :tue_to
      t.string :wed_from
      t.string :wed_to
      t.string :thur_from
      t.string :thur_to
      t.string :fri_from
      t.string :fri_to
      t.string :sat_from
      t.string :sat_to
      t.string :sun_from
      t.string :sun_to
      t.timestamps
    end
  end
end