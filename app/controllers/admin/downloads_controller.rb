class Admin::DownloadsController < Admin::ResourceController
  
  def index
    @readers = Reader.find(:all)
    
    if params[:reader]
      @reader = Reader.find_by_id(params[:reader])
      @downloads = Download.find_all_by_reader_id(params[:reader])
      @folders = DownloadFolder.find_all_by_reader_id(params[:reader])
    end
  end
    
end