class User < ActiveRecord::Base
  attr_reader :password
  validates :password_digest, :presence => true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true, :uniqueness => true
  validates :user_name, :presence => true, :uniqueness => true

  validates :session_token, presence: true
  after_initialize :ensure_session_token

  has_many(
    :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Cat"
  )

  def self.find_by_credentials(username, password)
    user = User.find_by_user_name(username)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end


end