class Proposal < ApplicationRecord
  has_many :comments

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
end
