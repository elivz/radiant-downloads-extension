class Download < ActiveRecord::Base

  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  has_and_belongs_to_many :readers
  default_scope :order => 'updated_at DESC, created_at DESC'

  has_attached_file :document,
                    :url => "/download_control/:id/:basename:no_original_style.:extension",
                    :path => ":rails_root/secure_downloads/:id/:basename:no_original_style.:extension"

  validates_attachment_presence :document
  
  def has_reader?(reader=nil)
    return true if readers and reader.nil?
    return false if reader.nil?
    return readers.include?(reader)
  end
  
  def available_to?(reader=nil)
    permitted_readers = self.readers  
    return false if permitted_readers.empty?
    return false if reader.nil?
    return true if reader.is_admin?
    return reader.in?(permitted_readers)
  end
  
  def document_ok?
    self.document.exists?
  end
    
end
