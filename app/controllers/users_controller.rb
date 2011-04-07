require 'pp'

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user=User.where(:id=>params[:id]).first
    if @user
      redirect_to user_messages_path([@user])
    else
      redirect_to '/' unless @user
    end
  end
  def index
    @users=User.limit(10)
  end
end
