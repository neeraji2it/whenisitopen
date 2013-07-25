class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :businesses, :thur_from, :thu_from
    rename_column :businesses, :thur_to, :thu_to
  end
end
