class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types

  def self.save_pokemon_names_to_db
    names = PokemonService.new.get_all_pokemon_names
    names.each { |pokemon| create!(name: pokemon['name']) }
  end
  # this iterates over each pokemon and it adds the types to the pokemon
  def self.save_pokemon_types_to_db
    all.each do |pokemon|
      pokemon.save_pokemon_types_to_db
    end
  end
  # this is a class method that I can call on each instance of the Pokemon class
  def save_pokemon_types_to_db
    types = PokemonService.new.get_pokemon_by_name(name)['types']
    types.each do |type|
      type_record = Type.find_or_create_by(name: type['type']['name'])
      self.types << type_record unless self.types.include?(type_record)
    end
  end
end
