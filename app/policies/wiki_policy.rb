class WikiPolicy < ApplicationPolicy

  def new?
    user.present?
  end    

  def create?
    user.present?
  end

  def edit?
    if user.present?
      user.owns?(record) || user.admin?
    else
      false
    end
  end

  def update?
    user.owns?(record)
  end

  def destroy?
    if user.present?
      user.owns?(record) || user.admin?
    else
      false
    end
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? == false
        @scope.where(:private => 0)
      elsif user.admin?
        @scope.all
      else
        @scope.where.not("private = ? AND user_id <> ?", 1, user.id)
      end
    end
  end

# two relations, one which has all the wikis which are NOT Private. Another one which has the private wikis of the current user.

  
end
