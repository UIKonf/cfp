module ProposalsHelper
  def show_comments?(proposal)
    proposal.published? || proposal.preselected?
  end

  def show_comment_form?
    %i{cfp review}.include?(Cfp.mode.mode)
  end

  def can_edit?
    %i{cfp review}.include?(Cfp.mode.mode)
  end
end
