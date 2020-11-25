# == Schema Information
#
# Table name: works
#
#  id           :bigint           not null, primary key
#  description  :text(65535)
#  is_published :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creater_id   :bigint           not null
#
# Indexes
#
#  index_works_on_creater_id  (creater_id)
#
# Foreign Keys
#
#  fk_rails_...  (creater_id => creaters.id)
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
