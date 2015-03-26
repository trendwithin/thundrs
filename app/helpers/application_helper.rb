module ApplicationHelper
  def flash_case(level)
    case level
    when :notice then "info"
    when :success then "success"
    when :error then "error"
    when :alert then "warning"
    end
  end

  def home_path
    current_user ? memories_path : root_path
  end
end
