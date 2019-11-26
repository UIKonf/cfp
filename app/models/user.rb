class User < ApplicationRecord
  before_save do
    email.downcase!
  end

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :github_uid, presence: true, uniqueness: true
  validates :github_nickname, presence: true

  def self.create_with_omniauth(auth_hash)
    create! do |user|
      user.name = auth_hash[:info][:name]
      user.email = auth_hash[:info][:email]
      user.github_uid = auth_hash[:uid]
      user.github_nickname = auth_hash[:info][:nickname]
    end
  end
end
