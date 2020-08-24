class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :creater, foreign_key: true, null: false
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
