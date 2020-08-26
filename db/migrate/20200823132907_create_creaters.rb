class CreateCreaters < ActiveRecord::Migration[6.0]
  def change
    create_table :creaters do |t|
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.integer :min_charge
      t.boolean :is_accepting, null: false, default: true

      t.timestamps
    end
  end
end
