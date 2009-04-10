require File.dirname(__FILE__) + '/../test_helper'
require 'private_group_controller'

# Re-raise errors caught by the controller.
class PrivateGroupController; def rescue_action(e) raise e end; end

class PrivateGroupControllerTest < Test::Unit::TestCase
  def setup
    @controller = PrivateGroupController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
