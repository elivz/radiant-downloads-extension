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
  
  def edit
    @folders = DownloadFolder.find_all_by_reader_id(@download.reader_id)
  end
  
  def update
    @download_folder = DownloadFolder.find(params[:id])
    if @download_folder.update_attributes(params[:download_folder])
      redirect_to :controller => 'admin/downloads', :action => 'index', :reader => @download_folder.reader_id
    else
       render :action => 'edit'
    end
  end
  
  def destroy
    @download_folder = DownloadFolder.find(params[:id]).destroy
    redirect_to :controller => 'admin/downloads', :action => 'index', :reader => @download_folder.reader_id
  end
  
end