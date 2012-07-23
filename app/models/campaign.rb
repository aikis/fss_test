class Campaign < ActiveRecord::Base
  belongs_to :status
  belongs_to :type
  belongs_to :owner, :class_name => "User"
  belongs_to :parent, :class_name => "Campaign"
  has_many :childs, :class_name => "Campaign", :foreign_key => "parent_id"

  def add_attr(options)
    status = self.update_attributes(:description => options[:description], :active => options[:active], :name => options[:name].capitalize!)
    self.parent = Campaign.find(options[:parent]) if !options[:parent].empty?
    self.type = Type.find(options[:type_id]) if !options[:type_id].empty?
    self.status = Status.find(options[:status_id]) if !options[:status_id].empty?
    self.owner = User.find(options[:owner_id]) if options[:owner_id] && !options[:owner_id].empty?
    status &&= save
  end
end
