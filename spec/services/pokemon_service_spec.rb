require 'rails_helper'

RSpec.describe PokemonService, type: :service do
  let(:pokemon_service) { PokemonService.new }

  before do
    stub_request(:get, "https://pokeapi.co/api/v2/pokemon").to_return(
      status: 200, 
      body: { results: [{ name: 'bulbasaur' }] }.to_json, 
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(:get, "https://pokeapi.co/api/v2/type").to_return(
      status: 200, 
      body: { results: [{ name: 'grass' }] }.to_json, 
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(:get, "https://pokeapi.co/api/v2/pokemon/bulbasaur").to_return(
      status: 200, 
      body: { name: 'bulbasaur', types: [{ type: { name: 'grass' } }] }.to_json, 
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(:get, "https://pokeapi.co/api/v2/type/grass").to_return(
      status: 200, 
      body: { pokemon: [{ pokemon: { name: 'bulbasaur' } }] }.to_json, 
      headers: { "Content-Type" => "application/json" }
    )
    
    stub_request(:get, "https://pokeapi.co/api/v2/pokemon/1").to_return(
      status: 200, 
      body: { name: 'bulbasaur' }.to_json, 
      headers: { "Content-Type" => "application/json" }
    )
  end

  describe '#get_all_pokemon_names' do
    it 'returns all pokemon names' do
      names = pokemon_service.get_all_pokemon_names

      expect(names).to eq([{ 'name' => 'bulbasaur' }])
    end
  end

  describe '#get_all_pokemon_types' do
    it 'returns all pokemon types' do
      types = pokemon_service.get_all_pokemon_types

      expect(types).to eq([{ 'name' => 'grass' }])
    end
  end

  describe '#get_pokemon_by_name' do
    it 'returns the pokemon with the given name' do
      pokemon = pokemon_service.get_pokemon_by_name('bulbasaur')

      expect(pokemon).to eq({ 'name' => 'bulbasaur', 'types' => [{ 'type' => { 'name' => 'grass' }}] })
    end
  end

  describe '#get_pokemon_by_type' do
    it 'returns the pokemon with the given type' do
      pokemon = pokemon_service.get_pokemon_by_type('grass')

      expect(pokemon).to eq({ 'pokemon' => [{ 'pokemon' => { 'name' => 'bulbasaur' }}] })
    end
  end

  describe '#get_pokemon_by_id' do
    it 'returns the pokemon with the given id' do
      pokemon = pokemon_service.get_pokemon_by_id(1)

      expect(pokemon).to eq({ 'name' => 'bulbasaur' })
    end
  end
end
