class DownloadFolder < ActiveRecord::Base

  belongs_to :reader
  has_many :downloads
  
  acts_as_tree :order => "name"
  
  default_scope :order => 'created_at ASC'
  
end