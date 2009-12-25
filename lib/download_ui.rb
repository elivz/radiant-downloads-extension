module DownloadUI

 def self.included(base)
   base.class_eval do

    attr_accessor :download, :download_folder
    alias_method :downloads, :download
    alias_method :download_folders, :download_folder
  
    def load_default_regions_with_download
      @download = load_default_download_regions
      @download_folder = load_default_download_folder_regions
    end
    alias_method_chain :load_default_regions, :download
  
    protected
  
      def load_default_download_regions
        returning OpenStruct.new do |download|
          download.edit = Radiant::AdminUI::RegionSet.new do |edit|
            edit.main.concat %w{edit_header edit_form}
            edit.form.concat %w{edit_title edit_description edit_document edit_access edit_folder}
            edit.form_bottom.concat %w{edit_timestamp edit_buttons}
          end
          download.index = Radiant::AdminUI::RegionSet.new do |index|
            index.thead.concat %w{name_header document_header access_header modify_header}
            index.tbody.concat %w{name_cell document_cell access_cell modify_cell}
            index.bottom.concat %w{new_button}
          end
          download.remove = download.index
          download.new = download.edit
        end
      end
  
      def load_default_download_folder_regions
        returning OpenStruct.new do |download_folder|
          download_folder.edit = Radiant::AdminUI::RegionSet.new do |edit|
            edit.main.concat %w{edit_header edit_form}
            edit.form.concat %w{edit_title}
            edit.form_bottom.concat %w{edit_timestamp edit_buttons}
          end
          download_folder.index = Radiant::AdminUI::RegionSet.new do |index|
            index.thead.concat %w{name_header document_header access_header modify_header}
            index.tbody.concat %w{name_cell document_cell access_cell modify_cell}
            index.bottom.concat %w{new_button}
          end
          download_folder.remove = download_folder.index
          download_folder.new = download_folder.edit
        end
      end
      
    end
  end
end