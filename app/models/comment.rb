class Comment < ActiveRecord::Base
  
  belongs_to :download
  belongs_to :reader
  
end
