class Admin::DownloadFoldersController < Admin::ResourceController

  def index
    @readers = Reader.find(:all)
  end
    
end