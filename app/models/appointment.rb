class Appointment < ApplicationRecord
  validates :user_id, presence: true
  validates :doctor_id, presence: true
  validates :date, presence: true

  belongs_to :user
  belongs_to :doctor

  scope :ordered_by_most_recent, -> { order(date: :asc) }
end
