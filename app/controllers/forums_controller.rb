class ForumsController < ApplicationController    
  load_and_authorize_resource
  skip_authorize_resource :only => :new
  
  def show
    @forum = Forum.find(params[:id])
    # @topics = @forum.topics.paginate(:page => params[:page], :per_page => 1)
    @search = @forum.topics.search do
      fulltext params[:search]
      paginate(:page => params[:page], :per_page => 1)
      # with(:published_at).less_than(Time.zone.now)
      # facet(:publish_month)
      # with(:publish_month, params[:month]) if params[:month].present?
    end
    @topics = @search.results
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(params[:forum])
    
    if @forum.save
      flash[:notice] = "Forum was successfully created."
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum = Forum.find(params[:id])
  end
  
  def update
    @forum = Forum.find(params[:id])
    
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "Forum was updated successfully."
      redirect_to forum_url(@forum)
    end
  end
  
  def destroy
    @forum = Forum.find(params[:id])
    
    if @forum.destroy
      flash[:notice] = "Forum was deleted."
      redirect_to forums_url
    end
  end
end