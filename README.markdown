Tornado
=======

Tornado is a ruby gem that let's you write ruby scripts that looks like this:

    tell OSX do
      hide_everything
    end

    tell Terminal do
      open_new_tab("~/dev/web_site")

      open_new_tab(DEV_DIR) do
        tail "~/dev/web_site/log/*.log"
      end
  
      open_new_tab("~/dev/web_site") do
        run "autotest"
      end
    end
    
    tell Textmate do
      minimize_all_windows
      open DEV_DIR
      resize 400, "100%"
      reposition :east
    end

    tell Firefox do
      open_new_tab("http://web-site.local")
    end

Documentation
-------------

None yet - this thing is new.

Why
-----

Tornado sits on top of Appscript, which is an Apple event bridge.
Appscript is GREAT, I wanted something even higher level.  Something
that would just let me easily do the common things I want to do when 
switching between projects: open terminals, run commands, open the
project in my text editor, minimize/hide other apps, etc.

See below for code comparisons:

Using Appscript directly:
-------------------------

    # hide all apps

    se = Appscript.app("System Events")
    se.keystroke("h", :using => [ :command_down, :option_down ])
    
    # open a tab in Terminal and run "autotest"

    t = Appscript.app("Terminal")
    t.launch unless t.is_running?
    se.application_processes["Terminal"].keystroke("t", :using => :command_down)
    tab = current_window.tabs.last
    term.do_script("cd ~/dev/web_site && clear && autotest", :in => tab)
    
Using Tornado:
--------------

    # hide all apps
    
    tell OSX do
        hide_everything
    end
    
    # open a tab in Terminal and run "autotest"
    tell Terminal do
        open_new_tab("~/dev/web_site") do
          run "autotest"
        end
    end
    

Copyright and License
---------------------

The MIT License

Copyright© 2008 Jim Garvin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
