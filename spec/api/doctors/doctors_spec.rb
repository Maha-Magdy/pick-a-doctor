require 'swagger_helper'
require 'rails_helper'
require 'database_cleaner/active_record'
require 'faker'

DatabaseCleaner.strategy = :truncation

RSpec.describe '/api/doctors', type: :request do
  before do
    DatabaseCleaner.clean
    Specialization.create(id: 1, name: 'Internal medicine')
    Specialization.create(id: 2, name: 'Pediatrics')
    Specialization.create(id: 3, name: 'Dermatology')
    Specialization.create(id: 4, name: 'Radiology')
  end
  path '/api/doctors' do
    post('User sign-up') do
      consumes 'application/json'
      parameter name: :doctor, in: :body, schema: {
        type: :object,
        properties: { id: { type: :integer }, specialization_id: { type: :integer }, first_name: { type: :string }, last_name: { type: :string },
                      email: { type: :string, format: :email }, address: { type: :string } },
        required: %w[id specialization_id first_name last_name email address]
      }
      response '201', 'created' do
        let(:doctor) do {
          specialization_id: Faker::Number.between(from: 1, to: 4),
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.unique.last_name,
          email: Faker::Internet.unique.email,
          phone: Faker::PhoneNumber.cell_phone_in_e164,
          address: Faker::Address.full_address
        }
        end
        run_test!
      end
      response '422', 'error' do
        let(:doctor) do
          { email: 'test@example.com', password_confirmation: '1234567', first_name: 'User2',
            last_name: 'Test2', date_of_birth: '12-10-2000' }
        end
        run_test!
      end
    end
  end
end
