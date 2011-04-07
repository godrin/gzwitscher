class MessageObserver < ActiveRecord::Observer
  def after_create(message) 
    Subscription.where(:author_id=>message.user_id).each{|subscription|
      rel=MessageRelation.new
      rel.user_id=subscription.user_id
      rel.message_id=message.id
      rel.save
    }

    User.find_by_sql(["select users.* from users,messages where text like '%'||email||'%' and messages.id=?",message.id]).each{|user|
      rel=MessageRelation.new
      rel.user_id=user.id
      rel.message_id=message.id
      rel.save
    }

  end
end
