class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  # mount_uploader :avatar, avatar_up_loader

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_name, presence: true, length: { minimum: 3 }

  validates :introduction, length: { maximum: 255 }
end
