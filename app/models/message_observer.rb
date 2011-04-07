class MessageObserver < ActiveRecord::Observer
  def after_create(message) 
    Subscription.where(:author_id=>message.user_id).each{|subscription|
      rel=MessageRelation.new
      rel.user_id=subscription.user_id
      rel.message_id=message.id
      rel.save
    }
  end
end
