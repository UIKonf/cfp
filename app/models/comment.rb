class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  validates :user_id, presence: true
  validates :proposal_id, presence: true
  validates :body, presence: true, length: {minimum: 10}

  default_scope { where('hidden = ?', false) }

  def hide!
    update(hidden: true)
  end
end
