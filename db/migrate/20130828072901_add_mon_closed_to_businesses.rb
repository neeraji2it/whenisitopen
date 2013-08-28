class AddMonClosedToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :mon_closed, :string
    add_column :businesses, :tue_closed, :string
    add_column :businesses, :wed_closed, :string
    add_column :businesses, :thu_closed, :string
    add_column :businesses, :fri_closed, :string
    add_column :businesses, :sat_closed, :string
    add_column :businesses, :sun_closed, :string
  end
end
