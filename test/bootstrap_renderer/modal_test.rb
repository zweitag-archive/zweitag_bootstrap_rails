require 'test_helper'

module BootstrapRenderer

  class ModalTest < ActionView::TestCase

    def setup
      @standard_modal = Modal.new({}, view).tap do |m|
        m.header "Head Content"
        m.body { "Body Content" }
        m.footer { "Foot Content" }
        m.launch_button "Button"
      end

      @empty_modal = Modal.new({}, view)
    end

    test "header" do
      expected_result = <<-EOF
        <div class="modal-header">
          <a href="#" class="close">&times;</a>
          <h3>Head Content</h3>
        </div>
      EOF

      assert_equal expected_result.squish_html, @standard_modal.send(:header_html).squish_html
    end

    test "empty header" do
      assert_nil @empty_modal.send(:header_html)
    end

    test "body" do
      expected_result = <<-EOF
        <div class="modal-body">Body Content</div>  
      EOF

      assert_equal expected_result.squish_html, @standard_modal.send(:body_html).squish_html
    end

    test "empty body" do
      assert_nil @empty_modal.send(:body_html)
    end

    test "footer" do
      expected_result = <<-EOF
        <div class="modal-footer">Foot Content</div>
      EOF

      assert_equal expected_result.squish_html, @standard_modal.send(:footer_html).squish_html
    end

    test "button" do

      expected_result = <<-EOF
        <button class="btn danger" data-backdrop="true" data-controls-modal="modal-from-dom" data-keyboard="true">Button</button>
      EOF
      
      assert_equal expected_result.squish_html, @standard_modal.send(:button_html).squish_html
    end

    test "empty button" do
      assert_nil @empty_modal.send(:button_html)
    end

    test "empty_footer" do
      assert_nil @empty_modal.send(:footer_html)
    end

    test "complete_html" do
      expected_result = <<-EOF
        <div class="modal hide fade" id="modal-from-dom">
          <div class="modal-header">
            <a href="#" class="close">&times;</a>
            <h3>Head Content</h3>
          </div>
          <div class="modal-body">Body Content</div>
          <div class="modal-footer">Foot Content</div>
        </div>
        <button class="btn danger" data-backdrop="true" data-controls-modal="modal-from-dom" data-keyboard="true">Button</button>
      EOF

      assert_equal expected_result.squish_html, @standard_modal.to_s.squish_html
    end

    test "empty complete html" do
      expected_result = <<-EOF
        <div class="modal hide fade" id="modal-from-dom">
        </div>
      EOF

      assert_equal expected_result.squish_html, @empty_modal.to_s.squish_html
    end
    
    test "different html id" do
      modal =  Modal.new({ :id => "custom_id" }, view).tap do |m|
        m.launch_button "Button"
      end

      expected_result = <<-EOF
        <div class="modal hide fade" id="custom_id"></div>
        <button class="btn danger" data-backdrop="true" data-controls-modal="custom_id" data-keyboard="true">Button</button>
      EOF

      assert_equal expected_result.squish_html, modal.to_s.squish_html
    end

  end
end
