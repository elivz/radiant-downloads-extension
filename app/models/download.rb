class Download < ActiveRecord::Base

  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  belongs_to :reader
  default_scope :order => 'updated_at DESC, created_at DESC'

  has_attached_file :document,
                    :url => "/download_control/:id/:basename:no_original_style.:extension",
                    :path => ":rails_root/secure_downloads/:id/:basename:no_original_style.:extension"

  validates_attachment_presence :document
  
  def has_reader?(this_reader=nil)
    return false if this_reader.nil?
    return false if reader.nil?
    return reader == this_reader
  end
  
  def available_to?(reader=nil)
    permitted_reader = self.reader  
    return false if permitted_reader.nil?
    return false if reader.nil?
    return true if reader.is_admin?
    return reader == permitted_reader
  end
  
  def document_ok?
    self.document.exists?
  end
    
end