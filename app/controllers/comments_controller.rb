class CommentsController < ReaderActionController
  
  before_filter :require_reader
  
  radiant_layout 'Downloads'

  def new
    @title = "New Comment"
    
    @comment = Comment.new
    @comment.reader_id = current_reader.id
    redirect_to downloads_url unless @comment.download_id = params[:download_id]
  end
  
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = 'Comment saved'
      redirect_to downloads_url
    else
      flash[:warning] = 'Comment could not be saved'
      render :action => "new", :download_id => @comment.download_id
    end
  end
  
end
