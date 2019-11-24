class CommentsController < ApplicationController
  def create
    @proposal = Proposal.find(params[:proposal_id])
    @comment = @proposal.comments.create(comment_params)
    @comment.save
    redirect_to proposal_path(@proposal)
  end

  def destroy
    @proposal = Proposal.find(params[:proposal_id])
    @comment = @proposal.comments.find(params[:id])
    @comment.destroy
    redirect_to proposal_path(@proposal)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
