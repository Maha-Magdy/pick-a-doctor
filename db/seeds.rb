require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed for specializations
spec_1 = Specialization.create(name: 'General Medicine')
spec_1.image.attach(io: File.open("#{Rails.root}/app/assets/general-medicine.jpg"), filename: 'general-medicine.jpg', content_type: 'image/jpg')

spec_2 = Specialization.create(name: 'Pediatrics')
spec_2.image.attach(io: File.open("#{Rails.root}/app/assets/pediatrician-doctor.jpg"), filename: 'pediatrician-doctor.jpg', content_type: 'image/jpg')

spec_3 = Specialization.create(name: 'Dermatology')
spec_3.image.attach(io: File.open("#{Rails.root}/app/assets/dermatologist.jpg"), filename: 'dermatologist.jpg', content_type: 'image/jpg')

spec_4 = Specialization.create(name: 'Radiology')
spec_4.image.attach(io: File.open("#{Rails.root}/app/assets/obstetrics.jpg"), filename: 'obstetrics.jpg', content_type: 'image/jpg')

# Seed for doctors
10.times do
  doc = Doctor.create(
    specialization_id: Faker::Number.between(from: 1, to: 4),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    address: Faker::Address.full_address
  )
  doc.profile_image.attach(io: File.open("#{Rails.root}/app/assets/img.png"), filename: 'img.png', content_type: 'image/png')
end

# Seed for appointments
10.times do
  appointment = Appointment.create(
    user_id: Faker::Number.between(from: 1, to: 2),
    doctor_id: Faker::Number.between(from: 1, to: 4),
    date: Faker::Date.between(from: '2022-05-1', to: '2022-06-30'),
    notes: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4)
  )
end

