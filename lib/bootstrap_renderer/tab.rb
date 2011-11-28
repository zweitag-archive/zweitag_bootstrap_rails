module BootstrapRenderer
  class Tab < Base

    def initialize(title, opts, view_context, &block)
      raise ArgumentError.new("You must define a title") if title.blank?

      super(view_context)
      @options = opts
      @title = title
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
end
