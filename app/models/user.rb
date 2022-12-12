class User < ApplicationRecord
  has_many :rooms
  mount_uploader :icon, ImgUploader
  # バリデーション
  validates :name, presence: true
  validates :profile, presence: true
  validates :email, uniqueness: true, presence: true
  validates :icon, presence: true
  validates :password, presence: true
end