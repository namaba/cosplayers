# == Schema Information
#
# Table name: requests
#
#  id                :bigint           not null, primary key
#  accept_deadline   :integer          default(0), not null
#  amount            :integer          default(0), not null
#  delivery_deadline :integer          default(0), not null
#  description       :text(65535)      not null
#  genre             :string(255)      default(NULL), not null
#  is_anonymous      :boolean          default(FALSE), not null
#  is_hidden         :boolean          default(FALSE), not null
#  status            :string(255)      default("offering"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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
