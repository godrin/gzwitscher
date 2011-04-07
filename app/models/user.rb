class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :messages

  def am_i_subscribed?(current_user)
    my_subscription(current_user)
  end
  def my_subscription(current_user)
    Subscription.where(:user_id=>current_user.id,:author_id=>self.id).first
  end
end
