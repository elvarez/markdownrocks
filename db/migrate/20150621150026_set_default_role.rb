class SetDefaultRole < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "standard"
  end
end
