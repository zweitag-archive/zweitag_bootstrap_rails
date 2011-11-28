require 'test_helper'

module BootstrapRenderer

  class TabsTest < ActionView::TestCase

    test "tabs" do
      tabs = Tabs.new({}, view).tap do |t|
        t.tab "External", :url=>"http://www.example.com"
        t.tab "Internal", :id => "internal" do
          "Internal content"
        end
      end

      expected_result = <<-EOF
        <ul class="tabs" data-tabs="tabs">
          <li><a href="http://www.example.com">External</a></li>
          <li><a href="#internal">Internal</a></li>
        </ul>
        <div class="tab-content" id="my-tab-content">
          <div class="tab-pane" id="internal">Internal content</div>
        </div>
      EOF

      assert_equal expected_result.squish_html, tabs.to_s.squish_html
    end

    test "pills" do
      pills = Tabs.new({ :type => :pills }, view).tap do |t|
        t.pill "External", :url=>"http://www.example.com"
        t.pill "Internal", :id => "internal" do
          "Internal content"
        end
      end

      expected_result = <<-EOF
        <ul class="pills" data-tabs="tabs">
          <li><a href="http://www.example.com">External</a></li>
          <li><a href="#internal">Internal</a></li>
        </ul>
        <div class="tab-content" id="my-tab-content">
          <div class="tab-pane" id="internal">Internal content</div>
        </div>
      EOF

      assert_equal expected_result.squish_html, pills.to_s.squish_html

    end

  end

end
