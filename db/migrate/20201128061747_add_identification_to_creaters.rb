class AddIdentificationToCreaters < ActiveRecord::Migration[6.0]
  def change
    add_column :creaters, :identification, :string, null: false, default: 'unidentified', after: :is_accepting
  end
end
