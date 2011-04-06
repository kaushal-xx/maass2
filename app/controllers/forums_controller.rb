class ForumsController < ApplicationController

  before_filter :hide_side_panels
  before_filter :load_forum, :except => [:index, :new, :create]

  layout "plain"

  def index
    @forum =  Forum.new
    @forums = Forum.find(:all)
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      flash[:notice] = "Successfully Created Forum."
      redirect_to forums_path
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @forum.attributes = params[:forum]
    if @forum.save
      flash[:notice] = "Successfully Updated Forum."
      redirect_to forums_path
    else
      flash[:error]= "Forum Was Not Successfully Updated."
      render 'new'
    end
  end
  
  def destroy
    @forum.destroy
    flash[:notice] = "Successfully Destroyed Forum."
    redirect_to forums_path
  end

  private

  def hide_side_panels
    if !current_user
      redirect_to new_user_session_path()
    end
    @hide_panels = true
  end

  def load_forum
    @forum = Forum.find(params[:id])
  end

end
