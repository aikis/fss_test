class User < ActiveRecord::Base
  has_many :campaigns, :foreign_key => "owner_id"
end
