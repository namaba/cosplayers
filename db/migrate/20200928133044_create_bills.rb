class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.references :request, null: false, foreign_key: true
      t.string :charge_id, null: false
      t.boolean :is_captured, null: false, default: false
      t.string :withdrawal_status, null:false, default: 'unapplied'
      t.datetime :applied_at
      t.datetime :withdrawn_at


      t.timestamps
    end
  end
end
