require 'rails_helper'
require 'swagger_helper'

RSpec.describe "Pokemons", type: :request do
  let!(:pokemon) do 
    types = ['grass'].map { |type_name| Type.find_or_create_by(name: type_name) }
    Pokemon.create(name: 'bulbasaur', types: types)
  end

  before do
    stub_request(:get, /https:\/\/pokeapi\.co\/api\/v2\/pokemon\/(\d+|\w+)/).
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'pokeapi.co',
          'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: {
        name: 'bulbasaur',
        types: [
          {
            slot: 1,
            type: {
              name: 'grass',
              url: 'https://pokeapi.co/api/v2/type/12/'
            }
          }
        ],
        abilities: [
          {
            ability: {
              name: 'overgrow',
              url: 'https://pokeapi.co/api/v2/ability/65/'
            }
          },
          {
            ability: {
              name: 'chlorophyll',
              url: 'https://pokeapi.co/api/v2/ability/34/'
            }
          }
        ]
      }.to_json)
  end
  describe "GET /index" do
    it "returns http success" do
      get "/pokemons"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    context "when pokemon exists" do
      it "returns http success" do
        get "/pokemons/#{pokemon.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context "when pokemon does not exist" do
      it "returns http not found" do
        get "/pokemons/0"
        expect(response).to have_http_status(:not_found)
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

            let(:id) do
              types = ['grass'].map { |type_name| Type.find_or_create_by(name: type_name) }
              Pokemon.create(name: 'bulbasaur', types: types).id
            end
          run_test!
        end

        response '404', 'Pokemon not found' do
          let(:id) { 0 }
          run_test!
        end
      end
    end
  end
end
