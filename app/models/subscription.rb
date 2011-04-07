class Subscription < ActiveRecord::Base
  validates_uniqueness_of :user_id, :author_id

  belongs_to :user
  def author
    User.find(self.author_id)
  end
  def author=(a)
    if a
      author_id=a.id
    else
      author_id=nil
    end
  end

end
