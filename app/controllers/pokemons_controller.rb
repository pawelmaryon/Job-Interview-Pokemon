class PokemonsController < ApplicationController
  def index
    if Pokemon.all.empty?
      Pokemon.save_pokemon_names_to_db
      Pokemon.save_pokemon_types_to_db
    end
    pokemons = Pokemon.all
    render json: pokemons, only: %i[id name], include: :types
  end

  # def show
  #   pokemon = Pokemon.find_by(id: params[:id]) || Pokemon.find_by(name: params[:name])
  #   if pokemon
  #     pokemon_details = PokemonService.new
  #     byebug
  #     pokemon_attributes = pokemon_details.get_pokemon_by_id(pokemon.id)
  #     byebug
  #     abilities = pokemon_details.get_pokemon_by_id(pokemon.id)["abilities"]
  #     list_of_abilities = []
  #     abilities.each do |ability|
  #       list_of_abilities << pokemon_details.get_pokemon_ability(ability["ability"]["name"])
  #     end
  #     byebug
  #     pokemon_as_json = pokemon.as_json
  #     pokemon_as_json[:abilities] = list_of_abilities
  #     render json: pokemon_as_json, include: :types
  #   else
  #     render json: { error: 'Pokemon not found' }, status: :not_found
  #   end
  # end
  def show
    pokemon = Pokemon.find_by(id: params[:id]) || Pokemon.find_by(name: params[:name])
    if pokemon
      pokemon_details = PokemonService.new
      full_attributes = pokemon_details.get_pokemon_by_id(pokemon.id)
      abilities = full_attributes["abilities"]
      list_of_abilities = []
      abilities.each do |ability|
        list_of_abilities << pokemon_details.get_pokemon_ability(ability["ability"]["name"])
      end
      filtered_attributes = full_attributes.slice("name", "base_experience", "height", "weight", "order", "is_default")
      pokemon_as_json = pokemon.as_json
      pokemon_as_json.merge!(filtered_attributes)
      pokemon_as_json[:abilities] = list_of_abilities
      render json: pokemon_as_json, include: :types
    else
      render json: { error: 'Pokemon not found' }, status: :not_found
    end
  end
end
