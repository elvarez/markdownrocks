class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators, dependent: :destroy
  

  attr_accessor :stripe_card_token


  def collaborators
    Collaborator.where(user_id: id)
  end

  def wikiz
    Wiki.where( id: collaborators.pluck(:wiki_id) )
  end
  
  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def owns?(thing)
    true if self.id == thing.user_id
  end

  def collaborator?(thing)
    coballorator = false
    thing.collaborators.each do |c|
      if c.user_id == self.id
        coballorator = true
      end
    end
    coballorator
  end
end
