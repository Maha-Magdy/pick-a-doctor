require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

spec_1 = Specialization.create(id: 1, name: 'Internal medicine')
spec_2 = Specialization.create(id: 2, name: 'Pediatrics')
spec_3 = Specialization.create(id: 3, name: 'Dermatology')
spec_4 = Specialization.create(id: 4, name: 'Radiology')

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
