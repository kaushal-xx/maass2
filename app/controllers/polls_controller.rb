class PollsController < ApplicationController

  before_filter :load_profile
  before_filter :load_resource, :except=>[:index,:show,:create,:new]

  def index
    @polls = @profile.polls.order("created_at desc").paginate(:page => @page, :per_page => POLLS_PER_PAGE)
    if @profile == @p && @polls.empty?
      flash[:notice] = 'You have not create any polls. Try creating one now.'
      redirect_to new_profile_poll_path
    end
    respond_to do |format|
      format.html
      format.rss {render :layout => false}
    end
  end

  def new
    @poll = @profile.polls.new
  end

  def create
    @profile= current_user.profile
    @poll = @profile.polls.build(params[:poll])
    if @poll.save
      flash[:notice] = 'Poll was successfully created.'
      redirect_to profile_polls_path
    else
      flash.now[:error] = 'Poll was not successfully created.'
      render 'new'
    end
  end

  def show    
    unless @poll = @profile.polls.find_by_id(params[:id])
      @poll = Poll.find(params[:id])
    end
  end

  def edit    
  end

  def update    
    if @poll.update_attributes!(params[:poll])
      flash[:notice] = 'Poll was successfully updated.'
      redirect_to profile_poll_path(@poll)
    else
      flash.now[:error] = 'Poll was not successfully updated.'
      render 'edit'
    end
  end

  def destroy    
    if @poll.destroy
      redirect_to profile_polls_path
    else
      flash[:error] = "Poll was not successfully destroyed."
    end
  end

  def poll_close    
    @poll.update_attributes(:status => false)
    redirect_to profile_polls_path
  end

  private

  def load_profile
    @profile = params[:profile_id] == @p ? @p : Profile.find(params[:profile_id])
    @show_profile_side_panel = true
  end

  def load_resource
    @profile =  current_user.profile
    @poll = @profile.polls.find(params[:id])
  end
  
  def allow_to
    super :owner, :all => true 
    super :active_user, :only => [:index, :show]
  end

end