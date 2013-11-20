class CreateRecentAddBusinesses < ActiveRecord::Migration
  def change
    create_table :recent_add_businesses do |t|
      t.integer :business_id
      t.string :company_name
      t.timestamps
    end
  end
end
