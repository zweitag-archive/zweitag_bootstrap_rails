require 'test_helper'

module BootstrapRenderer

  class TabTest < ActionView::TestCase

    def setup
      @default_tab = Tab.new("Title", {}, view) { "Content" }
      @custom_tab = Tab.new("Title", { :title_html_options => { :'data-custom' => 'some-data' }, :content_html_options => { :class => 'some-class' } }, view) { "Content" }
      @disabled_tab = Tab.new("Title", { :disabled => true }, view) { "Content" }
      @active_tab = Tab.new("Title", { :active => true }, view) { "Content" }
      @empty_tab = Tab.new("Title", {}, view)
    end

    test "title" do
      expected_result = <<-EOF
      <li><a href="#title" data-toggle="tab">Title</a></li>
      EOF

      assert_equal expected_result.squish_html, @default_tab.title_html.squish_html
    end

    test "title with custom html" do
      expected_result = %Q|<li data-custom="some-data"><a href="#title" data-toggle="tab">Title</a></li>|

      assert_equal expected_result.squish_html, @custom_tab.title_html.squish_html
    end

    test "disabled title" do
      expected_result = %Q|<li class="disabled"><a href="#title" data-toggle="tab">Title</a></li>|

      assert_equal expected_result.squish_html, @disabled_tab.title_html.squish_html
    end

    test "empty title" do
      assert_raise ArgumentError do
        Tab.new("", {}, view)
      end
    end

    test "content html" do
      expected_result = <<-EOF
      <div class="tab-pane" id="title">Content</div>
      EOF

      assert_equal expected_result.squish_html, @default_tab.content_html.squish_html
    end

    test "content html with options" do
      expected_result = %Q|<div class="some-class tab-pane" id="title">Content</div>|

      assert_equal expected_result.squish_html, @custom_tab.content_html.squish_html
    end

    test "disabled content html" do
      expected_result = %Q|<div class="tab-pane" id="title">Content</div>|

      assert_equal expected_result.squish_html, @disabled_tab.content_html.squish_html
    end
    
    test "active content" do
      expected_result = <<-EOF
      <div class="tab-pane active" id="title">Content</div>
      EOF

      assert_equal expected_result.squish_html, @active_tab.content_html.squish_html
    end

    test "empty content" do
      assert_nil @empty_tab.content_html
    end

    test "html_id by option" do
      assert_equal "option_id", Tab.new("Title", { :id => "option_id" }, view).send(:html_id)
    end

    test "html_id by title" do
      assert_equal "this_is_my_title", Tab.new("This is my Title", {}, view).send(:html_id)
    end

    test "active class" do
      assert_equal({ :class => "active" }, Tab.new("Title", { :active => true }, view).send(:title_html_options))
    end

    test "no active class" do
      assert_equal({ }, Tab.new("Title", {}, view).send(:title_html_options))
    end

    test "target by url" do
      assert_equal "http://www.example.com", Tab.new("Title", { :url => "http://www.example.com" }, view).send(:target)
    end

    test "target by id" do
      assert_equal "#option_id", Tab.new("Title", { :id => "option_id" }, view).send(:target)
    end

  end

end
