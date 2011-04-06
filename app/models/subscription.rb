class Subscription < ActiveRecord::Base
  validates_uniqueness_of :user_id, :author_id

  belongs_to :user
  has_one :author, :class_name=>"User"
end
