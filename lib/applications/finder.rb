module Tornado::Applications::Finder
  
  def minimize_all_windows
    app.activate
    app.windows.collapsed.set(true) # finder uses "collapsed"
  end
  
end
