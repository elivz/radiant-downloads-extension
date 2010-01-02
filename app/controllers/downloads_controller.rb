class DownloadsController < ReaderActionController
  
  before_filter :require_reader, :only => [:index, :show]
  
  radiant_layout 'Downloads'

  def index
    @reader = current_reader
    @folders = DownloadFolder.find_all_by_reader_id_and_parent_id(@reader.id, nil)
    @title = "Files for #{@reader.name}"
  end
    
  def show
    @radiant_layout = { :layout => false }
    
    @download = Download.find(params[:id])
    if @download.available_to?(current_reader)
      response.headers['X-Sendfile'] = @download.document.path
      response.headers["Content-Type"] = @download.document_content_type
      response.headers['Content-Disposition'] = "attachment; filename=#{@download.document_file_name}" 
      response.headers['Content-Length'] = @download.document_file_size
      render :nothing => true
    else
      flash[:error] = "Sorry: you don't have permission to download that file."
      render :template => 'reader/permission_denied'
    end
  end
  
end


