# == Schema Information
#
# Table name: requests
#
#  id           :bigint           not null, primary key
#  amount       :integer          default(0), not null
#  description  :text(65535)      not null
#  genre        :string(255)      default("photo"), not null
#  is_anonymous :boolean          default(FALSE), not null
#  is_hidden    :boolean          default(FALSE), not null
#  status       :string(255)      default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creater_id   :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_requests_on_creater_id  (creater_id)
#  index_requests_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (creater_id => creaters.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :request do
    genre { "MyString" }
    amount { 1 }
    description { "MyText" }
    deadline { "MyString" }
    anonymous { false }
    hidden { false }
    status { "MyString" }
  end
end
