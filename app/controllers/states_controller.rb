class StatesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @state_pages, @states = paginate :states, :per_page => 10
  end

  def show
    @state = State.find(params[:id])
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(params[:state])
    if @state.save
      flash[:notice] = 'State was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @state = State.find(params[:id])
  end

  def update
    @state = State.find(params[:id])
    if @state.update_attributes(params[:state])
      flash[:notice] = 'State was successfully updated.'
      redirect_to :action => 'show', :id => @state
    else
      render :action => 'edit'
    end
  end

  def destroy
    State.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
