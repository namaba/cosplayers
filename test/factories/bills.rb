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
FactoryBot.define do
  factory :bill do
    request { nil }
    charge_id { "MyString" }
    is_captured { false }
    withdrawal_status { "MyString" }
  end
end
