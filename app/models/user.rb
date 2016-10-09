class User < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  def self.find_user_by(value)
    where(["username = :value OR email = :value", {value: value}]).first
  end
end
