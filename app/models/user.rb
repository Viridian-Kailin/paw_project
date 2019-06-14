# frozen_string_literal: true
#:nodoc:
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password
end
