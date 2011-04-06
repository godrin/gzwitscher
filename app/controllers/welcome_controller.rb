class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @subscriptions=Subscription.where(:user_id=>current_user.id).all
      @messages=MessageRelation.where(:user_id=>current_user.id).order("created_at desc").limit(30).map{|relation|relation.message}
      @someusers=User.limit(10)
      render :mixed_list
    else
      render :index
    end
#    redirect_to user_messages_url(current_user) if user_signed_in?
  end
end
