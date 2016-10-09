class User < ApplicationRecord
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  def self.find_user_by(value)
    where(["username = :value OR email = :value", {value: value}]).first
  end

  def send_login_link
    generate_login_token

    template = 'login_link'
    EmailNotifier.send(template).deliver_now
  end

  def generate_login_token
    self.login_token = generate_token
    self.token_generated_at = Time.now.utc
    save!
  end

  def login_link
    "http://localhost:3000/auth?#{self.login_token}"
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

end
