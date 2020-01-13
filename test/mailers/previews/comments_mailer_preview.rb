# Preview all emails at http://localhost:3000/rails/mailers/comments_mailer
class CommentsMailerPreview < ActionMailer::Preview
  def new_comment_email
    CommentsMailer.with(proposal: Proposal.first, comment: Comment.first).new_comment_email
  end
end
