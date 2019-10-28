class AddImageLinkToLegos < ActiveRecord::Migration
  def change
    add_column :legos, :img_link, :string
  end
end
