require 'rubygems'
require 'appscript'

module Tornado
  VERSION = "0.0.1"
  
  def tell(app, &block)
    if block_given?
      app.instance_eval &block
    end 
  end
  
  def const_missing(name)
    return GenericApplication.find_by_string(name.to_s) || super(name)
  end
  
  module Applications; end
end

Object.extend(Tornado)
extend(Tornado)

require 'generic_application'

