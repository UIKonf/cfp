module SelectionsHelper
  def remaining_selection_count
     SelectionsController::LIMIT - @selections.count
  end

  def maximum_reached
    SelectionsController::LIMIT == @selections.count
  end
end
