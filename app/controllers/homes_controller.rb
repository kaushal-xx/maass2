class HomesController < ApplicationController
  
  def index
    blogs = Blog.all(:conditions => { :public => true })
    polls = Poll.public.open_polls.all(:include => :profile)
    events = Event.all(:include => :profiles)
    @home_data = sorted_results(blogs,polls).paginate(:page => @page,:per_page => 10)
  end
  
end