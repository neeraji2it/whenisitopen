class AddTimestampsToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :created_at, :datetime
    add_column :businesses, :updated_at, :datetime
  end
end
