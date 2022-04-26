class User < ApplicationRecord
        extend Devise::Models
        # Include default devise modules.
        devise :database_authenticatable, :registerable,
                :recoverable, :rememberable, :validatable
        include DeviseTokenAuth::Concerns::User
  has_one_attached :profile_image
end
