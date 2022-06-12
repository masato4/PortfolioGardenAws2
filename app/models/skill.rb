class Skill < ApplicationRecord
  belongs_to :user


  # with_options presence: true do
  #   validates :language_name
  #   validates :image
  #   validates :evaluation
  # end

  mount_uploader :image, ImageUploader


end
