class Admin::DownloadsController < Admin::ResourceController
  
  def index
    @readers = Reader.find(:all)
    
    if params[:reader]
      @reader = Reader.find_by_id(params[:reader])
      @downloads = Download.find_all_by_reader_id(params[:reader])
      @folders = DownloadFolder.find_all_by_reader_id(params[:reader])
    end
  end
  
  def edit
    @folders = DownloadFolder.find_by_reader_id(params[:reader])
  end
  
  def new
    @folders = DownloadFolder.find_all_by_reader_id(params[:reader_id])
    @download.reader_id = params[:reader_id]
    @download.download_folder_id = params[:download_folder_id]
  end
  
  def create
    @download = Download.new(params[:download])
    if @download.save
      redirect_to :controller => 'admin/downloads', :action => 'index', :reader => @download.reader_id
    else
      render :action => "new"
    end
  end
    
end