class CreateSearchLimits < ActiveRecord::Migration
  def change
    create_table :search_limits do |t|
      t.integer :searching_limit, :default => 0
      t.timestamps
    end
  end
end
