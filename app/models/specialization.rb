class Specialization < ApplicationRecord
  validates :name, presence: true
  has_many :doctors
end
