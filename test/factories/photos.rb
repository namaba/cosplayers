# == Schema Information
#
# Table name: photos
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  work_id     :bigint           not null
#
# Indexes
#
#  index_photos_on_work_id  (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (work_id => works.id)
#
FactoryBot.define do
  factory :photo do
    work { nil }
    description { "MyText" }
  end
end
