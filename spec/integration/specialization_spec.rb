require 'swagger_helper'

describe 'Specializations API' do
  # rubocop:disable Metrics/BlockLength
  path '/api/specializations' do
    get 'Retrives all specializations' do
      tags 'Specializations'
      produces 'application/json'

      response '200', 'All specializations retrived' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 },
                 required: %w[id name created_at updated_at]
               }
        let(:specializations) { Specialization.all }
        run_test!
      end
    end

    post 'Creates a specialization' do
      tags 'Specializations'
      consumes 'application/json', 'application/xml'
      produces 'application/json'
      parameter name: :name, in: :query, type: :string

      response '200', 'specialization created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name created_at updated_at]

        let(:specialization) do
          { id: 1, name: 'Emergency medicine', created_at: '2022-04-27T20:12:01.849Z',
            updated_at: '2022-04-27T20:49:30.664Z' }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:specialization) { { name: 'Emergency medicine' } }
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength

  # rubocop:disable Metrics/BlockLength
  path '/api/specializations/{id}' do
    get 'Retrives a specialization' do
      tags 'Specializations'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'specialization edited' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name created_at updated_at]

        run_test!
      end

      response '422', 'invalid request' do
        let(:specialization) { { name: 'Emergency medicine' } }
        run_test!
      end
    end

    put 'Edits a specialization' do
      tags 'Specializations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :name, in: :query, type: :string

      response '200', 'specialization edited' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id name created_at updated_at]

        run_test!
      end

      response '422', 'invalid request' do
        let(:specialization) { { name: 'Emergency medicine' } }
        run_test!
      end
    end

    delete 'Destroys a specialization' do
      tags 'Specializations'
      parameter name: :id, in: :path, type: :string

      response '200', 'Specialization has been deleted.' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end

      response '404', "Couldn't find Specialization with 'id'=-" do
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
