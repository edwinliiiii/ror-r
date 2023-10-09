class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :types, array: true, default: []
      t.string :imageLink
      t.timestamps
    end
  end
end
