module ApplicationHelper
  def flash_class(key)
    case key.to_sym
    when :success then "is-primary"
    when :danger  then "is-danger"
    else "is-info"
    end
  end
end
