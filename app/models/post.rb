class Post < ApplicationRecord
  belongs_to :user
  include ImageUploader::Attachment.new(:image)
  validates :description, presence: true
end