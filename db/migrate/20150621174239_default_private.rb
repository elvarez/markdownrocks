class DefaultPrivate < ActiveRecord::Migration
  def change
    change_column :wikis, :private, :integer, :default => 0
  end
end
