# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class DownloadsExtension < Radiant::Extension
  version "0.5"
  description "Controlled file access by client."
  url "http://elivz.com"
  
  define_routes do |map|
    map.resources :downloads
    map.namespace :admin, :path_prefix => 'admin/readers' do |admin|
      admin.resources :downloads
      admin.resources :download_folders
      admin.download_folder_move_higher "download_folders/:id/move_higher", :controller => :download_folders, :action => "move_higher"
      admin.download_folder_move_lower "download_folders/:id/move_lower", :controller => :download_folders, :action => "move_lower"
    end
  end
  
  extension_config do |config|
    config.gem 'paperclip'
    config.extension 'reader'
  end
  
  def activate
    Page.send :include, DownloadTags
    UserActionObserver.instance.send :add_observer!, Download

    unless defined? admin.download
      Radiant::AdminUI.send :include, DownloadUI
      admin.download = Radiant::AdminUI.load_default_download_regions
      admin.download_folder = Radiant::AdminUI.load_default_download_folder_regions
    end

    admin.tabs['Clients'].add_link('downloads', '/admin/readers/downloads')
  end
  
  def deactivate
  end
  
end