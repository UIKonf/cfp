class CommentsMailer < ApplicationMailer
  default from: 'questions@uikonf.com', cc: 'sabine@uikonf.com'

  def new_comment_email
    @proposal = params[:proposal]
    @comment = params[:comment]
    mail(to: @proposal.user.email, subject: "[UIKonf] Someone just posted a suggestion on: #{@proposal.title}")
  end
end
