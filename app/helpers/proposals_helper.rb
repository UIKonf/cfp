module ProposalsHelper
  def show_comments?(proposal)
    proposal.published? || proposal.preselected?
  end

  def create_proposal_button
    if can?(:create, :proposal)
      link_to 'New Proposal', new_proposal_path, class: 'btn btn-primary'
    end
  end

  def edit_proposal_button
    if can?(:update, :proposal)
      link_to 'Edit', edit_proposal_path(@proposal), class: 'btn btn-primary'
    end
  end

  def publish_or_withdraw_proposal_button
    if @proposal.can_withdraw? && can?(:withdraw, :proposal)
      link_to 'Withdraw', withdraw_proposal_path(@proposal), method: :post, class: 'btn btn-warning', data: {confirm: 'Are you sure?'}
    elsif @proposal.can_publish? && can?(:publish, :proposal)
      link_to 'Publish', publish_proposal_path(@proposal), method: :post, class: 'btn btn-success', data: {confirm: 'Are you sure?'}
    end
  end

  def delete_proposal_button
    if can?(:destroy, :proposal)
      link_to 'Delete Forever', proposal_path(@proposal), method: :delete, class: 'btn btn-danger', data: {confirm: 'Are you sure?'}
    end
  end
end
