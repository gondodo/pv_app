class AddIndexImpression < ActiveRecord::Migration
  def change
    add_index :impressions, [:url, :browser, :platform, :created_at]
  end
end
