# == Schema Information
#
# Table name: credit_cards
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  card_id     :string(255)      not null
#  customer_id :string(255)      not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_credit_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :credit_card do
    user { nil }
    customer_id { "MyString" }
    card_id { "MyString" }
  end
end
