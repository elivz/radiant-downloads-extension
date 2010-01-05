class Comment < ActiveRecord::Base
  
  belongs_to :download
  belongs_to :reader
  
  after_create :send_comment_notification

  def send_comment_notification
    CommentMailer.deliver_comment_notification(self)
  end

end
