class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  validates :body, presence: true, length: { minimum: 20 }
end
