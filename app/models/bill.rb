# == Schema Information
#
# Table name: bills
#
#  id                :bigint           not null, primary key
#  is_captured       :boolean          default(FALSE), not null
#  withdrawal_status :string(255)      default("unapplied"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  charge_id         :string(255)      not null
#  request_id        :bigint           not null
#
# Indexes
#
#  index_bills_on_request_id  (request_id)
#
# Foreign Keys
#
#  fk_rails_...  (request_id => requests.id)
#
class Bill < ApplicationRecord
  belongs_to :request
end
