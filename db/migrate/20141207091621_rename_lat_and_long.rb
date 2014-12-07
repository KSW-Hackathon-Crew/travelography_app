class RenameLatAndLong < ActiveRecord::Migration
  def change
    rename_column :activities, :latitude, :lat
    rename_column :activities, :longitude, :long
  end
end
