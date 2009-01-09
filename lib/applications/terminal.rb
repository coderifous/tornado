module Tornado::Applications::Terminal

  def open_new_tab(path=nil, &block)
    Terminal.ensure_launched
    Terminal.keystroke("t", :using => :command_down)
    tab = Tab.new(app.windows.first.tabs.last)
    if path
      tab.cd(path) 
      tab.clear
    end
    if block_given?
      tab.instance_eval(&block)
    end
    tab
  end
  
  class Tab
    attr_reader :tab
    
    def initialize(tab)
      @tab = tab
    end
    
    def run(cmd)
      Terminal.do_script(cmd, :in => @tab)
    end
    
    def clear
      run "clear"
    end
    
    def clear_scrollback
      @tab.selected.set(true)
      Terminal.keystroke("k", :using => :command_down)
    end
    
    def cd(path)
      run "cd #{path}"
    end
  end
end
