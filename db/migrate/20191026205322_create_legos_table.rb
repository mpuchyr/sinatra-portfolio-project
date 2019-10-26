class CreateLegosTable < ActiveRecord::Migration
  def change
    create_table :legos do |t|
      t.string :name
      t.string :theme
      t.integer :num_of_pieces
      t.integer :user_id
    end
  end
end
