class AddStatusToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :status, :string
  end
end
