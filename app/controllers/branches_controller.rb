class BranchesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @branch_pages, @branches = paginate :branches, :per_page => 10
  end

  def show
    @branch = Branch.find(params[:id])
  end

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(params[:branch])
    if @branch.save
      flash[:notice] = 'Branch was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @branch = Branch.find(params[:id])
  end

  def update
    @branch = Branch.find(params[:id])
    if @branch.update_attributes(params[:branch])
      flash[:notice] = 'Branch was successfully updated.'
      redirect_to :action => 'show', :id => @branch
    else
      render :action => 'edit'
    end
  end

  def destroy
    Branch.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
