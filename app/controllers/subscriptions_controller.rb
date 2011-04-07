class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    user=User.where(:id=>params[:user_id]).first
    if user and user!=current_user
      s=Subscription.new
      s.author_id=user.id
      s.user_id=current_user.id
      s.save
    end  
    redirect_to user_path(user)
  end
  def destroy
    s=Subscription.where(:id=>params[:id],:user_id=>current_user.id).first
    if s
      other_user_id=s.author_id
      s.delete
      redirect_to user_path(User.find(other_user_id))
    else
      redirect_to '/'
    end
  end
end
