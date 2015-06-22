class AddPrivateToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :private, :integer
  end
end
