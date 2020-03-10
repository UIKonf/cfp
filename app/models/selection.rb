class Selection < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  validate :maximum_number_of_selections

  LIMIT = 8

  private

  def maximum_number_of_selections
    if Selection.where(user_id: user.id).count > LIMIT
      errors[:base] << "You can only select #{LIMIT} proposals at a time"
    end
  end
end
