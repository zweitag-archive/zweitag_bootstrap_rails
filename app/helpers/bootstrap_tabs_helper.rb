module BootstrapTabsHelper

  class BootstrapTabsRenderer

    def initialize(opts = {}, view_context)
      @options = default_options.merge(opts)

      @view_context = view_context
      @tabs = []
    end

    def default_options
      { :class => :tabs }
    end

    def tab(title, opts={}, &block)
      @tabs << BootstrapTabRenderer.new(title, opts, h, &block)
      nil
    end

    def to_s
      (titles + content).html_safe
    end

    def h
      @view_context
    end

    def titles
      h.content_tag :ul, :class => @options[:class], :"data-tabs" => "tabs" do
        @tabs.map(&:title_html).join.html_safe
      end
    end

    def content
      h.content_tag :div, :id => "my-tab-content", :class => "tab-content" do
        @tabs.map(&:content_html).join.html_safe
      end
    end

  end

  class BootstrapTabRenderer

    def initialize(title, opts, view_context, &block)
      @options = opts
      @title = title
      @view_context = view_context
      @block = block

    end

    def title_html
      h.content_tag :li, :class => active_class do
        h.link_to @title, target
      end
    end

    def content_html
      return unless @block

      h.content_tag :div, :id => html_id, :class => ["tab-pane", active_class].compact do
        @block.call
      end
    end

    private

    def h
      @view_context
    end

    def active?
      @options[:active]
    end

    def active_class
      active? ? "active" : nil
    end

    def target
      @options[:url] || "##{html_id}"
    end

    def html_id
      @options[:id] || @title.underscore.gsub(' ', '_')
    end

  end

  def bootstrap_tabs(opts = {}, &block)
    renderer = BootstrapTabsRenderer.new(opts, self)
    yield renderer
    renderer
  end
end
