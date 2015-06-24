class Wiki < ActiveRecord::Base

  belongs_to :user
  has_many :collaborators, dependent: :destroy


  def collaborators
    Collaborator.where(wiki_id: id)
  end

  def users
    User.where( :id => collaborators.pluck(:user_id) )
  end
  
  def private?
    self.private == 1
  end

  def belongsto?(userr)
    user_id == userr.id
  end

end
