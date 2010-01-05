class CommentMailer < ActionMailer::Base

  def comment_notification(comment)
    recipients    Radiant::Config['site.admin_email']
    from          "#{comment.reader.name} <#{comment.reader.email}>"
    subject       "New comment notification"
    sent_on       Time.now
    body          :comment => comment
  end
  
end