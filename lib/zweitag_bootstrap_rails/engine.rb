module ZweitagBootstrapRails
  class Engine < Rails::Engine

    initializer "simple_form_bootstrap" do
      SimpleForm.setup do |config|
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
      end if defined?(SimpleForm)
    end 

  end
end
