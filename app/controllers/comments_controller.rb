# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_mode

  def index
    @proposal = Proposal.find(params[:proposal_id])
    redirect_to proposal_path(@proposal)
  end

  def create
    @proposal = Proposal.find(params[:proposal_id])
    @comment = current_user.comments.create(comment_params.merge(proposal: @proposal))
    if @comment.save
      redirect_to proposal_path(@proposal)
    else
      render 'proposals/show'
    end
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
