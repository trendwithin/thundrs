class MemoryPolicy < ApplicationPolicy
  def update?
    @record.creator == @user
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        @user.memories
      end
    end
  end
end
