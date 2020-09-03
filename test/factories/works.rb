# == Schema Information
#
# Table name: works
#
#  id           :bigint           not null, primary key
#  genre        :string(255)      default("photo"), not null
#  is_premium   :boolean          default(FALSE), not null
#  is_published :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creater_id   :bigint           not null
#  request_id   :bigint
#
# Indexes
#
#  index_works_on_creater_id  (creater_id)
#  index_works_on_request_id  (request_id)
#
# Foreign Keys
#
#  fk_rails_...  (creater_id => creaters.id)
#  fk_rails_...  (request_id => requests.id)
#
FactoryBot.define do
  factory :work do
    creater { nil }
    genre { "MyString" }
    url { "MyString" }
    is_published { false }
    is_premium { false }
  end
end
