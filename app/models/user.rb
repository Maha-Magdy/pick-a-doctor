class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :appointments
end
