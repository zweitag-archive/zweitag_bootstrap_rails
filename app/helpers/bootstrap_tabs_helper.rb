module BootstrapTabsHelper

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
