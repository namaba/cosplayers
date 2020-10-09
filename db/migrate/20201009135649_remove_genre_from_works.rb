class RemoveGenreFromWorks < ActiveRecord::Migration[6.0]
  def up
    remove_column :works, :genre, :string
    remove_column :works, :is_premium, :boolean
  end

  def down
    add_column :works, :genre, :string, null: false, default: 'photo'
    add_column :works, :is_premium, :boolean, null: false, default: false
  end
end
