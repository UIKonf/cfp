class Proposal < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :state, presence: true
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 200 }

  STATES = %w{draft published preselected withdrawn deleted}

  STATES.each do |state|
    define_method("#{state}?") do
      self.state == state
    end

    define_method("#{state}!") do
      self.update(state: state)
    end
  end

end
