class Wiki < ActiveRecord::Base

  belongs_to :user

  def private?
    self.private == 1
  end

  def belongsto?(userr)
    user_id == userr.id
  end

end
