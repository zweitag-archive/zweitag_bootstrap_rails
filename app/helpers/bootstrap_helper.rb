module BootstrapHelper

  def bootstrap_flash_message_type(type)
    case type
    when :alert
      "warning"
    when :error
      "error"
    when :notice
      "info"
    when :success
      "success"
    else
      type.to_s
    end
  end
  
  def bootstrap_topbar(&block)
    content_tag(:div, :class => 'topbar') do
      content_tag(:div, :class => 'topbar-inner') do
        content_tag(:div, :class => 'container-fluid') do
          yield
        end
      end
    end
  end

end
