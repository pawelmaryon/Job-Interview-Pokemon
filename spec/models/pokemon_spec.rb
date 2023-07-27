require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  let(:pokemon_service) { instance_double(PokemonService) }
  let(:pokemon_data) { { 'name' => 'bulbasaur', 'types' => [{'type' => { 'name' => 'grass' }}] } }

  before do
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
      expect(Type.first.pokemon).to eq(pokemon)
    end
  end
end
