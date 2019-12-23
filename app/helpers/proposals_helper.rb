module ProposalsHelper
  def can_withdraw?(proposal)
    proposal.published?
  end

  def show_comments?(proposal)
    proposal.published?
  end
end
