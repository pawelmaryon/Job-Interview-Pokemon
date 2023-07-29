class PokemonsController < ApplicationController
  @@database_populated = false

  before_action :populate_db
  
  def index
    pokemons = Pokemon.all
    render json: pokemons, only: %i[id name], include: :types
  end

  def show
    pokemon = Pokemon.find_by(id: params[:id]) || Pokemon.find_by(name: params[:name])
    if pokemon
      pokemon_details = PokemonService.new
      pokemon_presenter = PokemonPresenter.new(pokemon, pokemon_details)
      render json: pokemon_presenter.as_json, include: :types
    else
      render json: { error: 'Pokemon not found' }, status: :not_found
    end
  end

  private

  def populate_db
    return if @@database_populated
    if Pokemon.all.empty?
      Pokemon.save_pokemon_names_to_db
      Pokemon.save_pokemon_types_to_db
    end
    @@database_populated = true
  end
end
