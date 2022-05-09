require 'swagger_helper'

describe 'Appointments API' do
  before do
    User.create(first_name: 'Test1', last_name: 'User', email: 'test@example.com', password: 'password123',
                date_of_birth: '10-01-2000', password_confirmation: 'password123')

    Specialization.create(id: 1, name: 'Internal medicine')

    Doctor.create(specialization_id: 1,
                  first_name: 'Doctor-first-name',
                  last_name: 'Doctor-last-name',
                  email: 'test@example.com',
                  phone: '1122334455',
                  address: 'address example')
  end

  # rubocop:disable Metrics/BlockLength
  path '/api/appointments' do
    get 'Retrieves all appointments' do
      tags 'Appointments'
      produces 'application/json'

      response '200', 'All appointments retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   doctor_id: { type: :integer },
                   date: { type: :string },
                   notes: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id user_id doctor_id date notes created_at updated_at]
               }
        let(:appointments) { Appointment.all }
        run_test!
      end
    end

    post 'Creates an appointment' do
      tags 'Appointments'
      consumes 'application/json', 'application/xml'
      produces 'application/json'
      parameter name: :user_id, in: :query, type: :integer
      parameter name: :doctor_id, in: :query, type: :integer
      parameter name: :date, in: :query, type: :string
      parameter name: :notes, in: :query, type: :string

      response '200', 'Appointment created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 doctor_id: { type: :integer },
                 date: { type: :string },
                 notes: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id user_id doctor_id date notes created_at updated_at]

        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength

  path '/api/user_appointments' do
    get 'Retrieves all the appointments for a specific user' do
      tags 'Appointments'
      produces 'application/json'
      parameter name: :id, in: :query, type: :string

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   doctor_id: { type: :integer },
                   date: { type: :string, format: :date },
                   notes: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id user_id doctor_id date notes created_at updated_at]
               }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/api/doctor_appointments' do
    get 'Retrieves all the appointments for a specific doctor' do
      tags 'Appointments'
      produces 'application/json'
      parameter name: :id, in: :query, type: :string

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   doctor_id: { type: :integer },
                   date: { type: :string },
                   notes: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id user_id doctor_id date notes created_at updated_at]
               }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  # rubocop:disable Metrics/BlockLength
  path '/api/appointments/{id}' do
    get 'Retrieves a specific appointment' do
      tags 'Appointments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 doctor_id: { type: :integer },
                 date: { type: :string },
                 notes: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id user_id doctor_id date notes created_at updated_at]

        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end

    put 'Edits a specific appointment' do
      tags 'Appointments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :date, in: :query, type: :string
      parameter name: :notes, in: :query, type: :string

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 doctor_id: { type: :integer },
                 date: { type: :string },
                 notes: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id user_id doctor_id date notes created_at updated_at]

        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end

    delete 'Destroys an appointment' do
      tags 'Appointments'
      parameter name: :id, in: :path, type: :string

      response '200', 'The appointment has been deleted.' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
