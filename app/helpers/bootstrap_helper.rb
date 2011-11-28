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

  def bootstrap_modal(opts = {}, &block)
    BootstrapRenderer::Modal.new(opts, self).tap do |renderer| 
      if block.arity == 0
        renderer.body { block.call }
      else
        yield renderer
      end
    end
  end

  def bootstrap_tabs(opts = {}, &block)
    tabs_or_pills(opts.merge(:type => :tabs), &block)
  end

  def bootstrap_pills(opts = {}, &block)
    tabs_or_pills(opts.merge(:type => :pills), &block)
  end

  private

  def tabs_or_pills(opts = {}, &block)
    BootstrapRenderer::Tabs.new(opts, self).tap do |renderer| 
      yield renderer
    end
  end

end
