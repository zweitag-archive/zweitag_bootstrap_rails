require 'bootstrap_renderer'

module ZweitagBootstrapRails
  class Engine < Rails::Engine

    # https://github.com/plataformatec/simple_form/wiki/Twitter-Bootstrap-integration
    initializer "simple_form_bootstrap" do

      if defined?(SimpleForm)

        module ::SimpleForm
          module Components 
            module ContainedInput 
              def contained_input 
                '<div class="input">' + input + (error.nil? ? '' : error) + '</div>'
              end 
            end 
          end 
          module Inputs 
            class Base 
              include SimpleForm::Components::ContainedInput
            end 
          end 
        end

        SimpleForm.setup do |config|
          config.components = [ :label, :contained_input ]

          # CSS class used on errors.
          config.error_class = :"help-inline"

          # CSS class to add for error notification helper.
          config.error_notification_class = "alert-message error"

          # CSS class to add to all wrapper tags.
          config.wrapper_class = :clearfix

          # CSS class to add to the wrapper if the field has errors.
          config.wrapper_error_class = :error

          # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
          config.collection_wrapper_tag = "ul class='inputs-list'"

          # You can wrap each item in a collection of radio/check boxes with a tag, defaulting to span.
          config.item_wrapper_tag = "li"

          # You can define the class to use on all forms. Default is simple_form.
          config.form_class = nil
        end

      end
    end 


    initializer "will_paginate_bootstrap" do
      # https://gist.github.com/1214011
      if defined?(WillPaginate)

        module ::WillPaginate
          module ActionView
            def will_paginate(collection = nil, options = {})
              options[:renderer] ||= BootstrapLinkRenderer
              super.try :html_safe
            end

            class BootstrapLinkRenderer < LinkRenderer
              protected

              def html_container(html)
                tag :div, tag(:ul, html), container_attributes
              end

              def page_number(page)
                tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
              end

              def previous_or_next_page(page, text, classname)
                tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
              end

              def gap
                tag :li, link(super, '#'), :class => 'disabled'
              end

            end
          end
        end


      end
    end

  end
end
