class Doctor < ApplicationRecord
  belongs_to :specializations
  has_one_attached :profile_image
end
