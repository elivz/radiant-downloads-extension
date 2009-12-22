class Admin::DownloadsController < Admin::ResourceController
  
  def index
    @readers = Reader.find(:all, :order => "LOWER(name)")
    @reader = Reader.find_by_id(params[:reader])
    @downloads = Download.find_all_by_reader_id(params[:reader])
    @folders = DownloadFolder.find_all_by_reader_id(params[:reader], :order => "LOWER(name)")
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
  
  def edit
    @folders = DownloadFolder.find_all_by_reader_id(@download.reader_id)
  end
  
  def update
    @download = Download.find(params[:id])
    if @download.update_attributes(params[:download])
      redirect_to :controller => 'admin/downloads', :action => 'index', :reader => @download.reader_id
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @download = Download.find(params[:id]).destroy
    redirect_to :controller => 'admin/downloads', :action => 'index', :reader => @download.reader_id
  end
    
end