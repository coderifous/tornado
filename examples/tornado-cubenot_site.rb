#!/usr/local/bin/ruby

require 'rubygems'
require 'tornado'

DEV_DIR = "~/dev/cubenot_site"

tell OSX do
  hide_everything
end

tell Terminal do
  open_new_tab(DEV_DIR)

  open_new_tab(DEV_DIR) do
    tail "~/dev/cubenot_site/log/*.log"
  end
  
  open_new_tab(DEV_DIR) do
    run "autotest"
  end
end

tell Textmate do
  minimize_all_windows
  open DEV_DIR
  resize 400, "100%", :animate => true
  reposition :south_east, :animate => true
end

tell Firefox do
  open_new_tab("http://cubenot-site.local")
end

Textmate.activate
