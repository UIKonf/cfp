# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @comment = current_user.comments.create(comment_params.merge(proposal: @proposal))
    flash[:danger] = 'Your comment could not be saved, maybe it is too short?' unless @comment.save
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
