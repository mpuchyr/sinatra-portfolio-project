class AddThemeIdToLegosTable < ActiveRecord::Migration
  def change
    remove_column :legos, :theme, :string
    add_column :legos, :theme_id, :integer
  end
end
