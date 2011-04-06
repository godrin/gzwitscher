class Message < ActiveRecord::Base
  validates_length_of :text,	:maximum => 142
  belongs_to :user
end
