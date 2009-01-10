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
  
  # For some reason (a bug), we have to add the window's height to both y-values in the coordinates
  def position_top_left_corner_at(x,y)
    b = current_bounds
    app.windows[0].bounds.set([x, y + height, x + width, y + height + height])
  end
  
  # same bug is addressed here
  def resize(w, h)
    b = current_bounds
    puts b.inspect
    w = absolutize_size(w, :width)
    h = absolutize_size(h, :height)
    app.windows[0].bounds.set([ b[0], b[1] + height, b[0] + w, b[1] + h + height ])
  end
  
  def absolutize_size(size, width_or_height)
    if size.to_s[-1].chr == "%"
      OSX.send("desktop_#{width_or_height}") * (size.to_f / 100)
    else
      size + height
    end
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
