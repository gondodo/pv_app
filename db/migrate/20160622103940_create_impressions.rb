class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.string :url
      t.string :browser
      t.string :browser_version
      t.string :platform
      t.timestamps null: false
    end
  end
end
