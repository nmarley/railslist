class User < ActiveRecord::Base
  has_secure_password
  has_many :lists, dependent: :destroy
  has_many :items, through: :lists
  has_many :user_list_permissions, dependent: :destroy
  has_many :attachments, dependent: :destroy

  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # ?
  def feed
    List.where("user_id = ?", id)
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
