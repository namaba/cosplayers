# == Schema Information
#
# Table name: bills
#
#  id                :bigint           not null, primary key
#  applied_at        :datetime
#  is_captured       :boolean          default(FALSE), not null
#  withdrawal_status :string(255)      default("unapplied"), not null
#  withdrawn_at      :datetime
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
require 'test_helper'

class BillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
