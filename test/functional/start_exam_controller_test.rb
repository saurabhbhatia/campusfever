require File.dirname(__FILE__) + '/../test_helper'
require 'start_exam_controller'

# Re-raise errors caught by the controller.
class StartExamController; def rescue_action(e) raise e end; end

class StartExamControllerTest < Test::Unit::TestCase
  fixtures :papers

  def setup
    @controller = StartExamController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = papers(:first).id
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

    assert_not_nil assigns(:papers)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:paper)
    assert assigns(:paper).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:paper)
  end

  def test_create
    num_papers = Paper.count

    post :create, :paper => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_papers + 1, Paper.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:paper)
    assert assigns(:paper).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Paper.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Paper.find(@first_id)
    }
  end
end
