module SelectionsHelper
  def remaining_selection_count
     Selection::LIMIT - @selections.count
  end

  def maximum_reached
    Selection::LIMIT == @selections.count
  end
end
