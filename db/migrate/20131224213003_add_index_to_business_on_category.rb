class AddIndexToBusinessOnCategory < ActiveRecord::Migration
  def change
    add_index :businesses, :category
  end
end
