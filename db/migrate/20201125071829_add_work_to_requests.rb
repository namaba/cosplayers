class AddWorkToRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :work, foreign_key: true, after: :creater_id
  end
end
