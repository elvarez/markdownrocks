class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  attr_accessor :stripe_card_token

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def owns?(thing)
    true if self.id == thing.user_id
  end

end
