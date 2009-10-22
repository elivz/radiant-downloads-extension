class Admin::DownloadsController < Admin::ResourceController
    
    @downloads = find_downloads_by_reader(:reader)
    
end