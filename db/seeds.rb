require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed for specializations
spec_1 = Specialization.create(name: 'Internal medicine')
spec_2 = Specialization.create(name: 'Pediatrics')
spec_3 = Specialization.create(name: 'Dermatology')
spec_4 = Specialization.create(name: 'Radiology')

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

