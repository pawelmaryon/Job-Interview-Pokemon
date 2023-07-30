RSpec.describe PokemonService, type: :service do
  let(:pokemon_service) { PokemonService.new }

  before do
    stub_request(:get, "https://pokeapi.co/api/v2/pokemon/?limit=20&offset=0")
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'pokeapi.co',
          'User-Agent'=>'Ruby'
        }
      )
      .to_return(status: 200, body: { results: [{ name: 'bulbasaur' }] }.to_json, headers: { "Content-Type" => "application/json" })
  end

  describe '#get_all_pokemon_names' do
    it 'returns all pokemon names' do
      names = pokemon_service.get_all_pokemon_names
      expect(names.first.name).to eq('bulbasaur')
    end
  end

  describe '#get_pokemon_by_name' do
    it 'returns the pokemon with the given name' do
      stub_request(:get, "https://pokeapi.co/api/v2/pokemon/bulbasaur")
        .to_return(
          status: 200,
          body: { name: 'bulbasaur', types: [{ type: { name: 'grass' } }] }.to_json,
          headers: { "Content-Type" => "application/json" }
        )
      pokemon = pokemon_service.get_pokemon_by_name('bulbasaur')
      expect(pokemon.name).to eq('bulbasaur')
      expect(pokemon.types.first.type.name).to eq('grass')
    end
  end

  describe '#pokemon_attributes' do
    it 'returns the attributes of the specified pokemon' do
      stub_request(:get, "https://pokeapi.co/api/v2/pokemon/bulbasaur")
        .to_return(
          status: 200,
          body: { 
            name: 'bulbasaur', 
            base_experience: 64, 
            height: 7, 
            weight: 69, 
            order: 1, 
            is_default: true,
            abilities: [
              {
                ability: {
                  name: 'overgrow',
                  url: 'https://pokeapi.co/api/v2/ability/65/'
                },
                is_hidden: false,
                slot: 1
              }
            ]
          }.to_json,
          headers: { "Content-Type" => "application/json" }
        )

      attributes = pokemon_service.pokemon_attributes('bulbasaur')
      expect(attributes['name']).to eq('bulbasaur')
      expect(attributes['base_experience']).to eq(64)
      expect(attributes['height']).to eq(7)
      expect(attributes['weight']).to eq(69)
      expect(attributes['order']).to eq(1)
      expect(attributes['is_default']).to eq(true)

      abilities = attributes.fetch('abilities', [])
      ability = abilities.first.fetch('ability', {}) unless abilities.empty?
      expect(ability['name']).to eq('overgrow') unless ability.nil?
    end
  end
end
