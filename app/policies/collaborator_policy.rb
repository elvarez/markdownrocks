class CollaboratorPolicy < ApplicationPolicy

  def create?
    user.admin? || user.premium? && record.wiki.user == user
  end

  def destroy?
    user.admin? || user.premium? && record.wiki.user == user
  end
    
end
