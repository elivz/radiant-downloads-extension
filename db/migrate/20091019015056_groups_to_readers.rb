class GroupsToReaders < ActiveRecord::Migration
  def self.up
    drop_table :downloads_groups
    
    create_table :downloads_readers, :id => false do |t|
      t.column :download_id, :integer
      t.column :reader_id, :integer
    end
  end

  def self.down
    drop_table :downloads_readers
    
    create_table :downloads_groups, :id => false do |t|
      t.column :download_id, :integer
      t.column :group_id, :integer
    end
  end
end
