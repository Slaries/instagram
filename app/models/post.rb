class Post < ApplicationRecord::Base
  include ImageUploader::Attachment(:image)


end
