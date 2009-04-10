require File.dirname(__FILE__) + '/../test_helper'
require 'faculty_admin_controller'

# Re-raise errors caught by the controller.
class FacultyAdminController; def rescue_action(e) raise e end; end

class FacultyAdminControllerTest < Test::Unit::TestCase
  def setup
    @controller = FacultyAdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
