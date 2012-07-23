class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.references :owner
      t.boolean :active
      t.integer :type_id
      t.integer :status_id
      t.references :parent
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
