require File.dirname(__FILE__) + '/../test_helper'
require 'faculty_admins_controller'

# Re-raise errors caught by the controller.
class FacultyAdminsController; def rescue_action(e) raise e end; end

class FacultyAdminsControllerTest < Test::Unit::TestCase
  fixtures :faculty_admins

  def setup
    @controller = FacultyAdminsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
