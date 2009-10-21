class CreateDownloadFolders < ActiveRecord::Migration
  def self.up
    create_table :download_folders do |t|
      t.column :name, :string
      t.column :parent_id, :integer
      t.column :reader_id, :integer
      t.timestamps
    end
    
    add_column :downloads, :download_folder_id, :integer
  end

  def self.down
    drop_table :download_folders
    remove_column :downloads, :download_folder_id
  end
end
