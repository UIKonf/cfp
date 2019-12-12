class Proposal < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 200 }
end
