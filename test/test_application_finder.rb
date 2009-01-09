require 'helpers/test_helpers'

class ApplicationFinderTest < Test::Unit::TestCase
  
  context "The Finder application" do
    
    setup do
      Appscript.stubs(:app).returns(mock)
    end
    
    should "be able to minimize all windows" do
      Finder.app.expects(:activate)
      mock2 = mock { expects(:set).with(true) }
      mock1 = mock { expects(:collapsed).returns(mock2) }
      Finder.app.expects(:windows).returns(mock1)
      Finder.minimize_all_windows
    end
    
  end
  
end