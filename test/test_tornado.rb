require 'helpers/test_helpers'

$main = self

class TornadoTest < Test::Unit::TestCase
  include TestHelpers
  include Tornado
  
  def test_tell
    $main.respond_to?(:tell)
    Object.new.respond_to?(:tell)
  end
  
  def test_automatic_application_reference_based_on_const_missing
    ensure_application_undefined :Terminal
    assert_application_not_defined :Terminal
    first_mention_of Terminal
    assert Terminal.kind_of?(GenericApplication)
  end
  
  def test_tell
    fake_app = mock(:nothing => true)
    tell fake_app do
      nothing
    end
  end
end
