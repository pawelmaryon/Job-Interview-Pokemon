# Purpose: To make API calls to the PokeAPI
class PokemonService

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
end
