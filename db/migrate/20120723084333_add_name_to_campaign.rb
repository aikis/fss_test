class AddNameToCampaign < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :name, :string
  end

  def self.down
    remove_column :campaigns, :name
  end
end
