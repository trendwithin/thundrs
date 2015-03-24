class CommentPolicy < ApplicationPolicy
  def update?
    @record.memory.creator == @user
  end

  def destroy?
    update?
  end

  def permitted_attributes
    @record.permitted_attributes
  end
end
