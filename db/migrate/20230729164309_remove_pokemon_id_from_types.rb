class RemovePokemonIdFromTypes < ActiveRecord::Migration[7.0]
  def change
    remove_column :types, :pokemon_id, :bigint
  end
end
