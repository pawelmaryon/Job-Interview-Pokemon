# Purpose: To make API calls to the PokeAPI
class PokemonService
  include HTTParty
  def initialize
    self.class.base_uri Rails.configuration.pokeapi_base_url
  end

  def get_all_pokemon_names
    response = self.class.get('/pokemon')
    JSON.parse(response.body)["results"]
  end

  def get_all_pokemon_types
    response = self.class.get('/type')
    JSON.parse(response.body)["results"]
  end

  def get_pokemon_by_name(name)
    response = self.class.get("/pokemon/#{name}")
    JSON.parse(response.body)
  end

  def get_pokemon_by_type(type)
    response = self.class.get("/type/#{type}")
    JSON.parse(response.body)
  end

  def get_pokemon_by_id(id)
    response = self.class.get("/pokemon/#{id}")
    JSON.parse(response.body)
  end

  def get_pokemon_ability(ability)
    response = self.class.get("/ability/#{ability}")
    JSON.parse(response.body)
  end

  def pokemon_attributes(pokemon_id)
    full_attributes = get_pokemon_by_id(pokemon_id)
    filtered_attributes = full_attributes.slice("name", "base_experience", "height", "weight", "order", "is_default")
    abilities = full_attributes["abilities"]
    list_of_abilities = abilities.map { |ability| get_pokemon_ability(ability["ability"]["name"]) }
    filtered_attributes.merge(abilities: list_of_abilities)
  end
end
