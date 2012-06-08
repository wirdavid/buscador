class Relation < ActiveRecord::Base
  attr_accessible :advertiser_id, :user_id
  belongs_to :user
  belongs_to :advertiser, :class_name => "User"

end
