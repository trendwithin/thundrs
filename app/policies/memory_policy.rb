class MemoryPolicy < ApplicationPolicy
  def update?
    @record.creator == @user
  end

  def edit?
    update?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
