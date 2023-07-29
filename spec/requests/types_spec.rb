require 'rails_helper'
require 'swagger_helper'

RSpec.describe "Types", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end
end

describe 'Types API' do
  path '/types' do
    get 'Retrieves all Pokemon types' do
      produces 'application/json'
      response '200', 'Types found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              name: { type: :string },
              pokemons: { 
                type: :array,
                items: {
                  properties: {
                    name: { type: :string }
                  }
                }
              }
            },
            required: [ 'id', 'name' ]
          }

        run_test!
      end
    end
  end

  path '/types/{id}' do
    get 'Retrieve a Type by id' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Type found' do
        schema type: :object,
          properties: {
                        id: { type: :integer },
                        name: { type: :string },
                        pokemons: {
                          type: :array,
                          items: {
                            properties: {
                              name: { type: :string }
                            }
                          }
                        }
                      },
          required: [ 'id', 'name' ]

        let(:id) { Type.create(name: 'grass').id }
        run_test!
      end
    end
  end
end
