require 'swagger_helper'
require 'rails_helper'
require 'database_cleaner/active_record'
require 'faker'

DatabaseCleaner.strategy = :truncation

RSpec.describe '/api/doctors', type: :request do
  before :each do
    DatabaseCleaner.clean
    Specialization.create(id: 1, name: 'Internal medicine')
    Specialization.create(id: 2, name: 'Pediatrics')
    Specialization.create(id: 3, name: 'Dermatology')
    Specialization.create(id: 4, name: 'Radiology')
    10.times do
      doc = Doctor.create(
        specialization_id: Faker::Number.between(from: 1, to: 4),
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.unique.last_name,
        email: Faker::Internet.unique.email,
        phone: Faker::PhoneNumber.cell_phone_in_e164,
        address: Faker::Address.full_address
      )
      doc.profile_image.attach(io: File.open("#{Rails.root}/app/assets/img.png"), filename: 'img.png',
                               content_type: 'image/png')
    end
  end

  path '/api/doctors' do
    post('Create doctor') do
      consumes 'application/json'
      tags 'Doctors'
      parameter name: :doctor, in: :body, schema: {
        type: :object,
        properties: { specialization_id: { type: :integer, default: 1 }, first_name: { type: :string },
                      last_name: { type: :string }, email: { type: :string, format: :email },
                      address: { type: :string } },
        required: %w[id specialization_id first_name last_name email address]
      }
      response '201', 'created' do
        let(:doctor) do
          { specialization_id: 1, first_name: 'First', last_name: 'Last',
            email: 'user@eamil.com', phone: '+01234567890', address: 'address, address' }
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

  path '/api/doctors' do
    get('Get all doctors') do
      consumes 'application/json'
      tags 'Doctors'
      response '200', 'ok' do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 data: { type: :array }
               },
               required: %w[success data]
        run_test! do
          body = JSON.parse(response.body)
          expect(body['data'].length).to eq(10)
        end
      end
    end
  end

  path '/api/doctors/1' do
    get('Show one doctors') do
      consumes 'application/json'
      tags 'Doctors'
      response '200', 'ok' do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 data: { type: :object }
               },
               required: %w[success data]
        run_test! do
          body = JSON.parse(response.body)
          expect(body['data']).to include('first_name')
          expect(body['data']).to include('last_name')
        end
      end
    end
  end

  path '/api/doctors/2' do
    put('Update doctor') do
      consumes 'application/json'
      tags 'Doctors'
      parameter name: :doctor, in: :body, schema: {
        type: :object,
        properties: { specialization_id: { type: :integer, default: 1 }, first_name: { type: :string },
                      last_name: { type: :string }, email: { type: :string, format: :email },
                      address: { type: :string } },
        required: %w[id specialization_id first_name last_name email address]
      }
      response '202', 'accepted' do
        let(:doctor) do
          { specialization_id: 1, first_name: 'UpdatedFirst', last_name: 'Last',
            email: 'user@email.com', phone: '+01234567890', address: 'address, address' }
        end
        run_test!
      end
      response '422', 'error' do
        let(:doctor) do
          { email: 'test' }
        end
        run_test!
      end
    end

    delete 'Delete a Doctor' do
      tags 'Doctors'
      response '200', 'ok' do
        run_test! { expect(JSON.parse(response.body)['success']).to eq(true) }
      end
    end
  end
end
