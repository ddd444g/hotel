class User < ApplicationRecord
  has_many :rooms
  mount_uploader :icon, ImgUploader
end