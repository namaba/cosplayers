# == Schema Information
#
# Table name: creaters
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  min_charge  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_creaters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :creater do
    user { nil }
    description { "MyText" }
    min_charge { 1 }
  end
end
