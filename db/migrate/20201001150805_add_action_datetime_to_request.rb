class AddActionDatetimeToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :requested_at, :datetime, after: :status
    add_column :requests, :accepted_at, :datetime, after: :requested_at
    add_column :requests, :completed_at, :datetime, after: :accepted_at
    add_column :requests, :canceled_at, :datetime, after: :completed_at
    add_column :requests, :declined_at, :datetime, after: :canceled_at
    add_column :requests, :expired_at, :datetime, after: :declined_at
  end
end
