require 'helpers/test_helpers'

class ApplicationOSXTest < Test::Unit::TestCase
  
  context "The tornado pseudo-app OSX" do
    
    should "use the System Events app" do
      Appscript.expects(:app).with("System Events")
      OSX.instance_variable_set(:@system_events, nil)
      OSX.system_events
    end
    
    should "use system events to hide all windows" do
      OSX.system_events.expects(:keystroke).with("h", :using => [ :command_down, :option_down ])
      OSX.hide_everything
    end
    
    should "use system events to open urls" do
      OSX.system_events.expects(:open_location).with("foo")
      OSX.open_location("foo")
    end
    
    should "use system events to access application processes by name" do
      processes = mock("processes"){ expects(:[] => "Foo") }
      OSX.system_events.expects(:application_processes).returns(processes)
      OSX["Foo"]
    end
    
    context "with running applications %w(Foo Bar Baz)" do
      
      setup do
        list = [ 
          stub(:name => stub(:get => "Foo")), 
          stub(:name => stub(:get => "Bar")),
          stub(:name => stub(:get => "Baz")) 
        ]
        processes = mock() do
          expects(:get).returns(list).at_least_once
        end
        OSX.system_events.expects(:application_processes).returns(processes).at_least_once
      end
      
      should "use system events to list application processes by name" do
        list = OSX.running_applications
        assert_equal %w(Foo Bar Baz), list
      end
      
    end
    
  end
  
end
