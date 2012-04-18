module BootstrapRenderer
  class Tabs < Base

    def initialize(opts = {}, view_context)
      super(view_context)

      @options = default_options.merge(opts)
      @tabs = []
    end

    def to_s
      (titles + content).html_safe
    end

    def tab(title, opts={}, &block)
      @tabs << Tab.new(title, opts, h, &block)
      nil
    end

    alias_method :pill, :tab

    private

    def default_options
      { :type => :tabs }
    end

    def titles
      h.content_tag :ul, :class => "nav nav-#{@options[:type]}", :"data-tabs" => "tabs" do
        @tabs.map(&:title_html).join.html_safe
      end
    end

    def content
      h.content_tag :div, :id => "my-tab-content", :class => "tab-content" do
        @tabs.map(&:content_html).join.html_safe
      end
    end


  end
end
