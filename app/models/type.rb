class Type < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: true }, presence: true
  has_and_belongs_to_many :pokemons
end
