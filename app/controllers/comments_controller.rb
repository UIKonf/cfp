# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_mode

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @comment = current_user.comments.create(comment_params.merge(proposal: @proposal))
    flash[:danger] = 'Your comment could not be saved, maybe it is too short?' unless @comment.save
    redirect_to proposal_path(@proposal)
  end

  def destroy
    @proposal = Proposal.find(params[:proposal_id])
    @comment = current_user.comments.find_by_id(params[:id])
    @comment&.hide!
    redirect_to proposal_path(@proposal)
  end

  private

  def check_mode
    check_mode_for_object(:comment)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
