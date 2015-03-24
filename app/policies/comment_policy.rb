class CommentPolicy < ApplicationPolicy
  def update?
    @record.memory.creator == @user
  end

  def destroy?
    update?
  end

  def permitted_attributes
    if update?
      [:approved]
    else
      [:body, :author_id, :memory_id]
    end
  end
end
