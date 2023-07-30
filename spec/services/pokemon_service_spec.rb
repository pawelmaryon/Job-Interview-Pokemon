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
end
