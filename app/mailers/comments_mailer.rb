class CommentsMailer < ApplicationMailer
  default from: 'questions@uikonf.com'

  def new_comment_email
    @proposal = params[:proposal]
    @comment = params[:comment]
    mail(to: @proposal.user.email, subject: "[UIKonf] Someone just posted a suggestion on: #{@proposal.title}")
  end

  def new_comment_audit_email
    @proposal = params[:proposal]
    @comment = params[:comment]
    mail(to: 'sabine@uikonf.com', subject: "[UIKonf] New suggestion on: #{@proposal.title}")
  end
end
