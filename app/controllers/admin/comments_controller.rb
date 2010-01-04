class Admin::CommentsController < Admin::ResourceController
    
    def index
      @download = Download.find_by_id(params[:download_id])
      @comments = @download.comments
    end
    
end