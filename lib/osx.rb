class OSX
  class << self
    def hide_everything
      system_events.keystroke("h", :using => [ :command_down, :option_down ])
    end
    
    def open_location(*args)
      args.each { |url| system_events.open_location(url) }
    end
    
    def system_events
      @system_events ||= Appscript.app("System Events")
    end
    
    def [](app_name)
      system_events.application_processes[app_name]
    end
    
    def running_applications
      system_events.application_processes.get.collect { |a| a.name.get }
    end
  end
end
