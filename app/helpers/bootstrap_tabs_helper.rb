module BootstrapTabsHelper

  def bootstrap_tabs(opts = {}, &block)
    BootstrapRenderer::Tabs.new(opts, self).tap do |renderer| 
      yield renderer
    end
  end

end
