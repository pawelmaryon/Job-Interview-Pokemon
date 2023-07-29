require 'rails_helper'
require 'swagger_helper'

RSpec.describe "Pokemons", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/pokemons/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/pokemons/show"
      expect(response).to have_http_status(:success)
    end
  end
end

describe 'Pokemons API' do
  path '/pokemons' do
    get 'Retrieves all Pokemon' do
      produces 'application/json'
      response '200', 'Pokemon found' do
        schema type: :array,
          items: {
            properties: {
              id: { type: :integer },
              name: { type: :string },
              types: { 
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

  path '/pokemons/{id}' do
    get 'Retrieve a Pokemon by id' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Pokemon found' do
        schema type: :object,
          properties: {
                        id: { type: :integer },
                        name: { type: :string },
                        types: { 
                          type: :array,
                          items: {
                            properties: {
                              name: { type: :string }
                            }
                          }
                        }
                      },
          required: [ 'id', 'name' ]

        let(:id) { Pokemon.create(name: 'bulbasaur', types: ['grass']).id }
        run_test!
      end
    end
  end
end
