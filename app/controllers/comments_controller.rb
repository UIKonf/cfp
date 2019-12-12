class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @comment = current_user.comments.create(comment_params.merge(proposal: @proposal))
    @comment.save
    redirect_to proposal_path(@proposal)
  end

  def destroy
    @proposal = Proposal.find(params[:proposal_id])
    @comment = current_user.comments.find_by_id(params[:id])
    @comment&.destroy
    redirect_to proposal_path(@proposal)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
