class SelectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_mode

  def index
    @selections = current_user.selections
    if @selections.count > 0
      @proposals = Proposal.preselected.where("id NOT IN (?)", @selections.map { |s| s.proposal_id })
    else
      @proposals = Proposal.preselected
    end
  end

  def create
    proposal = Proposal.find(params[:proposal_id])
    unless proposal.preselected?
      flash[:error] = "You can only select a preselected proposal"
      redirect_to root_url
      return
    end

    if Selection.where(user_id: current_user.id).count >= Selection::LIMIT
      flash[:error] = "You already selected the maximum number of proposals"
      redirect_to user_selections_url(current_user)
      return
    end

    selection = current_user.selections.create(proposal: proposal)
    if selection.save
      redirect_to user_selections_url
    else
      flash[:error] = selection.errors.full_message.to_sentence
    end
  end

  def destroy
    selection = current_user.selections.find(params[:id])
    selection.destroy
    redirect_to user_selections_url
  end

  private

  def check_mode
    check_mode_for_object(:selection)
  end
end
