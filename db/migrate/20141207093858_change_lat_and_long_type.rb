class ChangeLatAndLongType < ActiveRecord::Migration
  def change
    remove_column :activities, :lat, :float
    remove_column :activities, :long, :float
    add_column :activities, :lat, :string
    add_column :activities, :long, :string
  end
end
