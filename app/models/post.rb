class Post < ApplicationRecord::Base
  include ImageUploader[:image]
  # validate :image_presence
  # def image_presence
  #   errors.add(:image, "Please download image")
  #     unless image.attached?
  #
  #     end
  # end


end
