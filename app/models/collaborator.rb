class Collaborator < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

belongs_to :wiki
belongs_to :user
  
end
