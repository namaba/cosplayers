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
class Photo < ApplicationRecord
  has_one_attached :photo_image

  belongs_to :work
  has_one :creater, class_name: 'Creater', through: :work
  has_one :user, class_name: 'User', through: :creater
end
