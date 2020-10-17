class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.references :work, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
