require File.dirname(__FILE__) + '/../test_helper'
require 'colleges_controller'

# Re-raise errors caught by the controller.
class CollegesController; def rescue_action(e) raise e end; end

class CollegesControllerTest < Test::Unit::TestCase
  fixtures :colleges

  def setup
    @controller = CollegesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = colleges(:first).id
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

    assert_not_nil assigns(:colleges)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:college)
    assert assigns(:college).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:college)
  end

  def test_create
    num_colleges = College.count

    post :create, :college => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_colleges + 1, College.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:college)
    assert assigns(:college).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      College.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      College.find(@first_id)
    }
  end
end
