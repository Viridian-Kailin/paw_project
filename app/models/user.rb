# frozen_string_literal: true

#:nodoc:
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  def self.find_user(name)
    user = User.find_by(username: name)
    user
  end
end
