class User < ApplicationRecord

  after_initialize :ensure_session_token!

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :username, uniqueness: true

  has_many :comments
  has_many :goals

  has_many :commented_goals,
    through: :comments,
    source: :goal

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def is_password?(password)
    bc_pass = BCrypt::Password.new(self.password_digest)
    bc_pass.is_password?(password)
  end

  def ensure_session_token!
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if user.is_password?(password)
    nil
  end
end
