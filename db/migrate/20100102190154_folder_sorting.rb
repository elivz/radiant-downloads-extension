class FolderSorting < ActiveRecord::Migration
  def self.up
    add_column :download_folders, :position, :integer
    
    # Set initial positions
    DownloadFolder.reset_column_information
    ActiveRecord::Base.record_timestamps = false
    Reader.find(:all).each do |r|
      put_children_into_list( DownloadFolder.find_all_by_reader_id_and_parent_id(r.id, nil, :order => "created_at asc") )
    end
    ActiveRecord::Base.record_timestamps = true
  end

  def self.down
    remove_column :download_folders, :position
  end
  
  def self.put_children_into_list(folders)
    folders.each_with_index do |f, idx|
      f.update_attribute('position', idx + 1)
      put_children_into_list( f.children.sort_by { |c| c.created_at } )
    end
  end
end
