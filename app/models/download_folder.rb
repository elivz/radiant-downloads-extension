class DownloadFolder < ActiveRecord::Base

  belongs_to :reader
  has_many :downloads
  
  acts_as_list
  acts_as_tree :order => "position"
  
  # scope_condition for acts_as_list
  def scope_condition
    if parent_id.nil?
      "reader_id = #{reader_id} AND parent_id IS NULL"
    else
      "reader_id = #{reader_id} AND parent_id = #{parent_id}"
    end
  end
  
  default_scope :order => 'position ASC'

end