require File.dirname(__FILE__) + '/../test_helper'
require 'friend_controller'

# Re-raise errors caught by the controller.
class FriendController; def rescue_action(e) raise e end; end

class FriendControllerTest < Test::Unit::TestCase
  def setup
    @controller = FriendController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
