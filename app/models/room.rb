class Room < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence: true
  mount_uploader :img, ImgUploader
end
