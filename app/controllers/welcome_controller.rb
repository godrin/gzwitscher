class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @subscriptions=Subscription.where(:user_id=>current_user.id).all
      @messages=MessageRelation.where(:user_id=>current_user.id).order("created_at desc").limit(30).map{|relation|relation.message}
      @followers=Subscription.where(:author_id=>current_user.id).all
      @someusers=User.limit(10)
      render :mixed_list
    else
      render :index
    end
  end
  def intro
  end
end
