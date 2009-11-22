class Admin::DownloadFoldersController < Admin::ResourceController

  def index
    @readers = Reader.find(:all)
  end
  
  def new
    @download_folder.reader_id = params[:reader_id]
  end
  
  def create
    @download_folder = DownloadFolder.new(params[:download_folder])
    if @download_folder.save
      redirect_to :controller => 'admin/downloads', :action => 'index', :reader => @download_folder.reader_id
    else
      render :action => "new"
    end
  end
  
end