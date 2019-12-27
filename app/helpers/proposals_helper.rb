module ProposalsHelper
  def show_comments?(proposal)
    proposal.published? || proposal.preselected?
  end
end
