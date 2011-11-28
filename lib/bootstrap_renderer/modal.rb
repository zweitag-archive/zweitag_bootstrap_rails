module BootstrapRenderer

  class BootstrapRenderer::Modal < Base

    def initialize(opts = {}, view_context, &block)
      super(view_context)

      @options = default_options.merge(opts)
      @tabs = []

      header(@options[:header])               if @options[:header]
      launch_button(@options[:launch_button]) if @options[:launch_button]
    end

    def body(&block)
      @body_block = block
      nil
    end

    def header(caption)
      @header_caption = caption
      nil
    end

    def footer(&block)
      @footer = true
      @footer_block = block
      nil
    end

    def launch_button(caption, opts = {})
      @button = true
      @button_caption = caption
      @button_options = { :class => "btn danger" }.merge(opts)
      nil
    end

    def to_s
      [modal_html, button_html].join.html_safe
    end

    private

    def modal_html
      h.content_tag :div, :id => @options[:id], :class => %w(modal hide fade) do
        [header_html, body_html, footer_html].join.html_safe
      end
    end

    def header_html
      if @header_caption
        h.content_tag :div, :class => "modal-header" do
          [
            h.link_to("&times;".html_safe, "#", :class => "close"),
            h.content_tag(:h3, @header_caption)
          ].join.html_safe
        end
      end
    end

    def body_html
      if @body_block
        h.content_tag :div, :class => "modal-body" do
          @body_block.call
        end
      end
    end

    def footer_html
      if @footer
        h.content_tag :div, :class => "modal-footer" do
          @footer_block.call
        end
      end
    end

    def button_html
      if @button
        h.content_tag :button, :data => { :"controls-modal" => @options[:id], :backdrop => true, :keyboard => true}, :class => @button_options[:class] do
          @button_caption
        end
      end
    end

    def default_options
      { :id => "modal-from-dom" }
    end

  end
end
