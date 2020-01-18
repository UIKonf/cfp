# frozen_string_literal: true

class ProposalsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show feed]
  before_action :check_mode
  before_action :allow_one_active_proposal, only: %i[new create publish]
  before_action :load_proposal_for_editing, only: %i[edit update destroy publish withdraw]

  def index
    @proposals = if Cfp.mode.mode == :selection
      Proposal.preselected.shuffle
    else
      Proposal.published_or_preselected.shuffle
                 end
    @withdrawn_proposals = Proposal.withdrawn
  end

  def feed
    @proposals = Proposal.published_or_preselected.last(10)
  end

  def show
    store_location unless logged_in? # Store location in case a user logs in
    @proposal = Proposal.find(params[:id])
    if @proposal.deleted? || @proposal.draft? && !current_user?(@proposal.user)
      raise ActiveRecord::RecordNotFound
    end

    @comment = Comment.new
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = current_user.proposals.create(proposal_params)
    if @proposal.save
      redirect_to @proposal
    else
      render 'new'
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to @proposal
    else
      render 'edit'
    end
  end

  def destroy
    @proposal.deleted!

    redirect_to proposals_path
  end

  def publish
    @proposal.published!
    flash[:success] = 'Your proposal has been published!'

    redirect_to @proposal
  end

  def withdraw
    @proposal.withdrawn!
    flash[:success] = 'Your proposal has been withdrawn!'

    redirect_to @proposal
  end

  private

  def check_mode
    check_mode_for_object(:proposal)
  end

  def proposal_params
    params.require(:proposal).permit(:title, :description)
  end

  def allow_one_active_proposal
    return unless current_user.proposals.where(state: 'published').count.positive?

    flash[:warning] = "You already proposed a talk. Please withdraw it first if you'd like to propose another one."
    redirect_to proposals_url
  end

  def load_proposal_for_editing
    @proposal = current_user.proposals.find_by_id(params[:id])
    return unless @proposal.nil?

    flash[:error] = 'You cannot edit proposals that are owned by other users'
    redirect_to proposals_url
  end
end
