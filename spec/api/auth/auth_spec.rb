require 'swagger_helper'
require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'api/auth', type: :request do
  path '/api/auth' do
    post('User sign-up') do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: { id: { type: :integer }, first_name: { type: :string }, last_name: { type: :string },
                      email: { type: :string, format: :email }, password: { type: :string },
                      password_confirmation: { type: :string }, date_of_birth: { type: :string, format: :date } },
        required: %w[id first_name last_name email password password_confirmation date_of_birth]
      }
      response '200', 'success' do
        let(:user) do
          { email: 'test@example.com', password: '1234567', password_confirmation: '1234567', first_name: 'User2',
            last_name: 'Test2', date_of_birth: '12-10-2000' }
        end
        run_test!
      end
      response '422', 'error' do
        let(:user) do
          { email: 'test@example.com', password_confirmation: '1234567', first_name: 'User2',
            last_name: 'Test2', date_of_birth: '12-10-2000' }
        end
        run_test!
      end
    end
  end

  path '/api/auth/sign_in' do
    before do
      DatabaseCleaner.clean
      User.create(first_name: 'Test1', last_name: 'User', email: 'test@example.com', password: 'password123',
                  date_of_birth: '10-01-2000', password_confirmation: 'password123')
    end
    post('User sign-in') do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: { email: { type: :string, format: :email }, password: { type: :string } },
        required: %w[email password]
      }
      response '200', 'success' do
        let(:user) do
          { email: 'test@example.com', password: 'password123' }
        end
        run_test! do |response|
          expect(response.has_header?('access-token')).to eq(true)
        end
      end
      response '401', 'fail' do
        let(:user) do
          { email: 'test@example.com', password: 'wrongpassword' }
        end
        run_test!
      end
    end
  end
end
