class Doctor < ApplicationRecord
  belongs_to :specialization
  has_one_attached :profile_image
end
