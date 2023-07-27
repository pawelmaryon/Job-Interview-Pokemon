class Pokemon < ApplicationRecord
  has_many :types

  def self.save_pokemon_names_to_db
    names = PokemonService.new.get_all_pokemon_names
    names.each{|pokemon| self.create!(name: pokemon["name"])}
  end

  def save_pokemon_types_to_db
    types = PokemonService.new.get_pokemon_by_name(self.name)["types"]
    types.each{|type| self.types.build(name: type["type"]["name"])}
    self.save
  end
end
