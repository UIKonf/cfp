class Proposal < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :selections, dependent: :destroy

  validates :user_id, presence: true
  validates :state, presence: true
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 200}

  default_scope { where("state != 'deleted'") }
  scope :published, -> { where(state: 'published') }
  scope :published_and_preselected, -> { where("state IN ('published', 'preselected')") }
  scope :preselected, -> { where(state: 'preselected') }

  STATES = %w{draft published preselected withdrawn deleted}

  STATES.each do |state|
    define_method("#{state}?") do
      self.state == state
    end

    define_method("#{state}!") do
      self.update(state: state)
    end
  end

  def can_publish?
    %w{draft withdrawn}.include?(self.state)
  end

  def can_withdraw?
    %w{published preselected}.include?(self.state)
  end
end
