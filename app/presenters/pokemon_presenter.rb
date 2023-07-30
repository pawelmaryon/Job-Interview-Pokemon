class PokemonPresenter
  def initialize(pokemon, service)
    @pokemon = pokemon
    @service = service
  end

  def as_json
    @pokemon.as_json.merge(@service.pokemon_attributes(@pokemon.id))
  end
end
