class AddDesctiptionToWork < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :description, :text, after: :genre
  end
end
