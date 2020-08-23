class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :requester, foreign_key: { to_table: :users }, null: false
      t.references :artist, foreign_key: { to_table: :users }, null: false
      t.string :genre, null: false, default: 'photo'
      t.integer :amount, null: false, default: 0
      t.text :description, null: false
      t.boolean :is_anonymous, null: false, default: false
      t.boolean :is_hidden, null: false, default: false
      t.string :status, null: false, default: 'offering'

      t.timestamps
    end
  end
end
