ActiveRecord::Schema[7.0].define(version: 2023_07_29_164309) do
  create_table "pokemons", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons_types", id: false, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "pokemon_id", null: false
    t.bigint "type_id", null: false
    t.index ["pokemon_id", "type_id"], name: "index_pokemons_types_on_pokemon_id_and_type_id"
    t.index ["type_id", "pokemon_id"], name: "index_pokemons_types_on_type_id_and_pokemon_id"
  end

  create_table "types", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
