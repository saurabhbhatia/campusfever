require File.dirname(__FILE__) + '/../test_helper'
require 'exams_controller'

# Re-raise errors caught by the controller.
class ExamsController; def rescue_action(e) raise e end; end

class ExamsControllerTest < Test::Unit::TestCase
  fixtures :exams

  def setup
    @controller = ExamsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = exams(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:exams)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:exam)
    assert assigns(:exam).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:exam)
  end

  def test_create
    num_exams = Exam.count

    post :create, :exam => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_exams + 1, Exam.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:exam)
    assert assigns(:exam).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Exam.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Exam.find(@first_id)
    }
  end
end
