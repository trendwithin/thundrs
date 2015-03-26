module ApplicationHelper
  def home_path
    current_user ? memories_path : root_path
  end
end
