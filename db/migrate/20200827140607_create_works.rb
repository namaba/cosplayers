class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.references :creater, null: false, foreign_key: true
      t.string :genre, null: false, default: 'photo'
      t.boolean :is_published, null: false, default: false
      t.boolean :is_premium, null: false, default: false

      t.timestamps
    end
  end
end
