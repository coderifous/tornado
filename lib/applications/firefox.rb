module Tornado::Applications::Firefox

  # depends on Firefox being the default browser, and 
  # configured to open new pages in new tabs
  def open_new_tab(*args)
    OSX.open_location(*args)
  end
    
end
