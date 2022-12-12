class Room < ApplicationRecord
  belongs_to :user, optional: true
  mount_uploader :img, ImgUploader

  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: true
  validates :img, presence: true
end
