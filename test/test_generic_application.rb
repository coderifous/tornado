require 'helpers/test_helpers'

class GenericApplicationTest < Test::Unit::TestCase
  include TestHelpers
  
  context "A GenericApplication" do
    
    setup do
      Appscript.stubs(:app).returns(mock("app"))
      OSX.stubs(:desktop_size).returns([0, 0, 1024, 768])
      @generic_app = GenericApplication.new(:name => "FakeApplication")
    end
    
    should "be able to resize first window with absolute values" do
      bounds = mock { expects(:set).with([100 , 100, 500, 500]) }
      windows = [ mock(:bounds => bounds) ]
      @generic_app.app.expects(:windows).returns(windows)
      @generic_app.expects(:current_bounds).returns([100,100,200,200])
      @generic_app.resize 400, 400
    end
    
    should "be able to resize first window with percent values" do
      bounds = mock { expects(:set).with([100 , 100, 612, 484]) }
      windows = [ mock(:bounds => bounds) ]
      @generic_app.app.expects(:windows).returns(windows)
      @generic_app.expects(:current_bounds).returns([100,100,200,200])
      @generic_app.resize "50%", "50%"
    end

    context "with position bzz" do
      setup do
        @generic_app.stubs(:current_bounds).returns([100,100,200,200])
        @bounds = mock
        windows = [ mock(:bounds => @bounds) ]
        @generic_app.app.expects(:windows).returns(windows)
      end
      
      should "be able to position first window in :north_east" do
        @bounds.expects(:set).with([924, 0, 1024, 100])
        @generic_app.position :north_east
      end
      
      should "be able to position first window in :south_east" do
        @bounds.expects(:set).with([924, 668, 1024, 768])
        @generic_app.position :south_east
      end
      
      should "be able to position first window in :north_west" do
        @bounds.expects(:set).with([0, 0, 100, 100])
        @generic_app.position :north_west
      end
      
      should "be able to position first window in :south_west" do
        @bounds.expects(:set).with([0, 668, 100, 768])
        @generic_app.position :south_west
      end
    end
    
    should "be able to close all windows" do
      windows = mock("windows") { expects(:close) }
      @generic_app.app.expects(:windows).returns(windows)
      @generic_app.close_all_windows
    end
    
    should "be able to minimize all windows" do
      stub_get_true  = stub(:get => true, :set => nil)
      stub_get_false = stub(:get => false)
      @generic_app.app.expects(:activate)
      window = mock("window") do
        expects(:visible).returns(stub_get_true).times(3)
        expects(:miniaturized).returns(stub_get_true).times(3)
      end
      non_visible_window = mock("non_visible_window") do
        expects(:visible).returns(stub_get_false)
        expects(:miniaturized).never
      end
      windows = mock(:get => [window, window, window, non_visible_window])
      @generic_app.app.expects(:windows).returns(windows)
      @generic_app.minimize_all_windows
    end
    
    should "be able to wait_for_me" do
      @generic_app.expects(:sleep).times(2)
      @generic_app.expects(:is_running?).times(3).returns(false, false, true)
      @generic_app.wait_for_me!
    end
    
    should "be able to ensure_launched" do
      @generic_app.expects(:is_running?).returns(false)
      @generic_app.app.expects(:launch)
      @generic_app.expects(:wait_for_me!)
      @generic_app.ensure_launched
    end
    
    should "be able to send keystrokes" do
      key, options = "h", { :using => :command_down }
      receiver     = mock { expects(:keystroke).with(key, options) }
      OSX.expects(:[]).with("FakeApplication").returns(receiver)
      @generic_app.keystroke(key, options)
    end
      
    should "send unrecognized methods to app" do
      @generic_app.app.expects(:a_method_that_does_not_exist)
      @generic_app.a_method_that_does_not_exist
    end
    
  end
  
  def test_extension_loading_for_app_with_extension
    ensure_application_undefined :Finder
    assert_application_not_defined :Finder
    first_mention_of Finder
    assert_application_defined :Finder
    assert_equal "applications/finder.rb", Finder.extension_path
    assert_equal Tornado::Applications::Finder, Finder.extension
  end
  
  def test_extension_loading_for_app_without_extension
    Appscript.stubs(:app).returns(true)
    assert_application_not_defined :ApplicationWithoutExtension
    first_mention_of ApplicationWithoutExtension
    assert_extension_not_defined :ApplicationWithoutExtension
  end
  
end
