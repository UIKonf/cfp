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
    selection = current_user.selections.create(proposal_id: params[:proposal_id])
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

  def selection_params
    params.require(:selection).permit(:proposal_id)
  end

  def check_mode
    check_mode_for_object(:selection)
  end
end
