class PokemonService
  def get_all_pokemon_names
    response = PokeApi.get(pokemon: {})
    response.results
  end

  def get_pokemon_by_name(name)
    PokeApi.get(pokemon: name)
  end

  def pokemon_attributes(pokemon_id)
    full_attributes = get_pokemon_by_name(pokemon_id)
    filtered_attributes = {
      "name" => full_attributes.name,
      "base_experience" => full_attributes.base_experience,
      "height" => full_attributes.height,
      "weight" => full_attributes.weight,
      "order" => full_attributes.order,
      "is_default" => full_attributes.is_default
    }
    abilities = full_attributes.abilities
    list_of_abilities = abilities.map { |ability| ability.ability.name }
    filtered_attributes.merge(abilities: list_of_abilities)
  end
end
