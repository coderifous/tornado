require 'helpers/test_helpers'

class ApplicationTerminalTest < Test::Unit::TestCase
  
  context "The Terminal application" do
    
    context "with a tab" do
      
      setup do
        Terminal
        @tab = Tornado::Applications::Terminal::Tab.new(stub)
      end
      
      should "be able to call run on tab" do
        Terminal.expects(:do_script).with("foo", :in => @tab.tab)
        @tab.run "foo"
      end
      
      should "be able to call clear on tab" do
        @tab.expects(:run).with("clear")
        @tab.clear
      end
      
      should "be able to call clear scroll back" do
        @tab.tab.expects(:selected).returns(mock { expects(:set).with(true) })
        Terminal.expects(:keystroke).with("k", :using => :command_down)
        @tab.clear_scrollback
      end
      
      should "be able to change directory" do
        @tab.expects(:run).with("cd /path")
        @tab.cd("/path")
      end
      
    end
    
    context "with mocked out tab" do
      
      setup do
        Terminal.expects(:ensure_launched)
        Terminal.expects(:keystroke).with("t", :using => :command_down)
        @tab = mock
        Tornado::Applications::Terminal::Tab.expects(:new).returns(@tab)
      end
    
      should "be able to open_new_tab without a path" do
        Terminal.open_new_tab
      end
      
      should "be able to open_new_tab with a path" do
        @tab.expects(:cd).with("/path/foo")
        @tab.expects(:clear)
        Terminal.open_new_tab("/path/foo")
      end
      
      should "be able to open_new_tab with a block" do
        @tab.expects(:some_method)
        Terminal.open_new_tab do
          some_method
        end
      end
      
    end
    
  end
  
end
