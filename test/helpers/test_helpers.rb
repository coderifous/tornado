require 'rubygems'
require 'test/unit'
require 'mocha'
require 'shoulda'
require 'tornado'

module TestHelpers
  def assert_responds_to(object, *methods)
    methods.each do |m| 
      assert object.respond_to?(m), "failed to respond to '#{m}'"
    end
  end
  
  def assert_application_not_defined(app_name)
    assert ! application_defined?(app_name)
  end
  
  def assert_application_defined(app_name)
    assert application_defined?(app_name)
  end
  
  def assert_extension_not_defined(app_name)
    assert ! Tornado::Applications.const_defined?(app_name)
  end
  
  def application_defined?(app_name)
    Kernel.const_defined?(app_name)
  end
  
  def ensure_application_undefined(app_name)
    Kernel.send(:remove_const, app_name) if application_defined?(app_name)
  end
  
  def first_mention_of(*args)
    # called solely for side effect of arguments being mentioned
  end
end
