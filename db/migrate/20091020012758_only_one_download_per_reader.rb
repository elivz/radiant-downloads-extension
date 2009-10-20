class OnlyOneDownloadPerReader < ActiveRecord::Migration
  def self.up
    drop_table :downloads_readers
    
    add_column :downloads, :reader_id, :integer
  end

  def self.down
    remove_column :downloads, :reader_id
    
    create_table :downloads_groups, :id => false do |t|
      t.column :download_id, :integer
      t.column :group_id, :integer
    end
  end
end
