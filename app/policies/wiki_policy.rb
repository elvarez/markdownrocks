class WikiPolicy < ApplicationPolicy

  def new?
    user.present?
  end    

  def create?
    user.present?
  end

  def edit?
    if user.present?
      user.owns?(record) || user.admin? || user.collaborator?(record)
    else
      false
    end
  end

  def update?
    user.owns?(record) || user.admin? || user.collaborator?(record)
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
      wikis = []
      if user.present? == false
        wikis = scope.where.not(private: 1)
      elsif user.admin?
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
    
  end


  
end
