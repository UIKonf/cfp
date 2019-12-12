# frozen_string_literal: true

require 'securerandom'

class User < ApplicationRecord
  before_save do
    email.downcase!
  end

  validates :name, presence: true
  validates :public_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :github_uid, presence: true, uniqueness: true
  validates :github_nickname, presence: true

  has_many :proposals, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.create_with_omniauth(auth_hash)
    create! do |user|
      user.name = auth_hash[:info][:name]
      user.public_name = SecureRandom.hex(7)
      user.email = auth_hash[:info][:email]
      user.github_uid = auth_hash[:uid]
      user.github_nickname = auth_hash[:info][:nickname]
    end
  end
end
