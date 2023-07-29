require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  let(:pokemon_service) { instance_double(PokemonService) }
  let(:type_name) { double('Type', name: 'grass') }
  let(:type) { double('PokeApi::Type', type: type_name) }
  let(:pokemon_data) { double('PokeApi::Pokemon', name: 'bulbasaur', types: [type]) }
  
  before do
    stub_request(:get, "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=0")
      .to_return(status: 200, body: { results: [{ name: 'bulbasaur' }, { name: 'pikachu' } ] }.to_json)

    allow(PokemonService).to receive(:new).and_return(pokemon_service)
    allow(pokemon_service).to receive(:get_all_pokemon_names).and_return([pokemon_data])
    allow(pokemon_service).to receive(:get_pokemon_by_name).with('bulbasaur').and_return(pokemon_data)
  end

  describe '.save_pokemon_names_to_db' do
    it 'saves pokemon names to the database' do
      expect { Pokemon.save_pokemon_names_to_db }.to change { Pokemon.count }.from(0).to(1)
      expect(Pokemon.first.name).to eq('bulbasaur')
    end
  end

  describe '#save_pokemon_types_to_db' do
    let(:pokemon) { Pokemon.create(name: 'bulbasaur') }

    it 'saves pokemon types to the database' do
      expect { pokemon.save_pokemon_types_to_db }.to change { Type.count }.from(0).to(1)
      expect(Type.first.name).to eq('grass')
      expect(Type.first.pokemons).to include(pokemon)
    end
  end
end
