class User < ApplicationRecord
  before_save do
    email.downcase!
  end

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :github_uid, presence: true, uniqueness: true
  validates :github_nickname, presence: true
end
