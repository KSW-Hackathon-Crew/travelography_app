class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :category
      t.string :photo_url
      t.float :latitude
      t.float :longitude
      t.references :plan, index: true

      t.timestamps
    end
  end
end
