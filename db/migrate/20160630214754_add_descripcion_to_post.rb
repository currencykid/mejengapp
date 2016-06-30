class AddDescripcionToPost < ActiveRecord::Migration
  def change
    add_column :posts, :descripcion, :text
  end
end
