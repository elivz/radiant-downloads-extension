class DownloadFolder < ActiveRecord::Base

  belongs_to :reader
  has_many :downloads
  
  default_scope :order => 'name ASC'
  
end
