class CommentPolicy < ApplicationPolicy
  def update?
    @record.memory.creator == @user
  end

  def destroy?
    update?
  end
end
