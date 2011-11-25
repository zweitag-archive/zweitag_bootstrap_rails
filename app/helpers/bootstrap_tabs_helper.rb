module BootstrapTabsHelper

  def bootstrap_tabs(opts = {}, &block)
    renderer = BootstrapRenderer::Tabs.new(opts, self)
    yield renderer
    renderer
  end
end
