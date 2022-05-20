class Doctor < ApplicationRecord
  belongs_to :specialization
  has_one_attached :profile_image
  has_many :appointments
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
