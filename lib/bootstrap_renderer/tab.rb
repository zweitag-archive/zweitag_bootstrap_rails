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
      h.content_tag :li, title_html_options do
        h.link_to @title, target, data_toggle
      end
    end

    def content_html
      return unless @block

      h.content_tag :div, content_html_options do
        @block.call
      end
    end

    private

    def active?
      @options[:active]
    end

    def disabled?
      @options[:disabled]
    end

    def title_html_options
      (@options[:title_html_options] || {}).tap do |options|
        classes = Array.wrap(options[:class]).compact
        classes << :active if active?
        classes << :disabled if disabled?
        options[:class] = classes.join(" ") if classes.present?
      end
    end

    def content_html_options
      (@options[:content_html_options] || {}).tap do |options|
        options[:id] = html_id

        classes = Array.wrap(options[:class]).compact
        classes << "tab-pane"
        classes << :active if active?
        options[:class] = classes.join(" ") if classes.present?
      end
    end

    def target
      @options[:url] || "##{html_id}"
    end

    def html_id
      @options[:id] || @title.underscore.gsub(' ', '_')
    end

    def data_toggle
      @options[:url] ? {} : { :data => { :toggle => 'tab' } }
    end

  end
end
