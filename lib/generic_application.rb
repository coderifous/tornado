require 'osx'

module GenericActions
  def close_all_windows
    app.windows.close
  end
  
  def minimize_all_windows
    app.activate
    app.windows.get.select { |w| w.visible.get }.each do |window|
      window.miniaturized.set(true)
    end
  end
  
  def wait_for_me!
    sleep(0.1) while !is_running?
  end

  def ensure_launched
    unless is_running?
      app.launch
      wait_for_me!
    end
  end
  
  def keystroke(*args)
    OSX[name].keystroke(*args)
  end
  
  # blindly pass on unrecognized methods to the appscript proxy
  def method_missing(meth, *args)
    app.send(meth, *args)
  end
end

module WindowPositionAndResizeActions
  def current_bounds
    app.windows[0].bounds.get
  end
  
  def position(cardinal_point)
    x, y = nil, nil
    case cardinal_point
      when :north_east
        x = OSX.desktop_width - width
        y = 0
      when :south_east
        x = OSX.desktop_width - width
        y = OSX.desktop_height - height
      when :north_west
        x, y = 0, 0
      when :south_west
        x = 0
        y = OSX.desktop_height - height
    end
    position_top_left_corner_at(x,y)
  end
  
  def position_top_left_corner_at(x,y)
    b = current_bounds
    app.windows[0].bounds.set([x, y, x + width, y + height])
  end
  
  def width
    b = current_bounds
    b[2] - b[0]
  end
  
  def height
    b = current_bounds
    b[3] - b[1]
  end
  
  def resize(width, height)
    b = current_bounds
    width  = absolutize_size(width, :width)
    height = absolutize_size(height, :height)
    app.windows[0].bounds.set([ b[0], b[1], b[0] + width, b[1] + height ])
  end
  
  def absolutize_size(size, width_or_height)
    if size.to_s[-1].chr == "%"
      OSX.send("desktop_#{width_or_height}") * (size.to_f / 100)
    else
      size
    end
  end
end

module ExtensionHelpers
  def extension
    Tornado::Applications.const_get(name)
  end
  
  def extension_path
    "applications/#{name.downcase.tr(" ", '_')}.rb"
  end
  
  def load_extension!
    begin
      require extension_path
      self.extend(extension)
    rescue NameError => e
      STDERR.puts "Extension not loaded: Expected #{extension_path} to define module Tornado::Applications::#{name}"
      STDERR.puts caller
    rescue LoadError => e
      STDERR.puts "Extension not found: #{extension_path}"
    end
  end
end

class GenericApplication
  include GenericActions
  include ExtensionHelpers
  include WindowPositionAndResizeActions
  
  attr_accessor :app, :name
  
  def initialize(opts)
    opts.each_pair { |k,v| self.send("#{k}=", v) }
    self.app = Appscript.app(name)
  end
  
  def self.find_by_string(name)
    if Appscript.app(name)
      application = GenericApplication.new(:name => name)
      application.load_extension!
      Kernel.const_set(name, application)
      return application
    else
      STDERR.puts "Couldn't find application named: #{name}"
      return false
    end
  end
end