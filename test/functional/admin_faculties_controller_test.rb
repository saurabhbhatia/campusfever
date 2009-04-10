require File.dirname(__FILE__) + '/../test_helper'
require 'admin_faculties_controller'

# Re-raise errors caught by the controller.
class AdminFacultiesController; def rescue_action(e) raise e end; end

class AdminFacultiesControllerTest < Test::Unit::TestCase
  fixtures :admin_faculties

  def setup
    @controller = AdminFacultiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
