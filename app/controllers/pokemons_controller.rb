class PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.all
    render json: pokemons, only: [:id, :name], include: :types
  end

  def show
    pokemon = Pokemon.find_by(id: params[:id]) || Pokemon.find_by(name: params[:name])
    render json: pokemon
  end
end
