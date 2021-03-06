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
class Work < ApplicationRecord
  has_one_attached :photo

  belongs_to :creater
  has_one :user, class_name: 'User', through: :creater
  has_one :request
  has_many :photos, dependent: :nullify
  accepts_nested_attributes_for :photos, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :creater_id
  validate :validate_photo

  def validate_photo
    errors.add(:photo, "画像データではありません。jpg/jpeg/png/gifのみアップロード可能です") unless image?
  end

  def image?
    return '' unless photo.attached?

    %w[image/jpg image/jpeg image/png image/gif].include?(photo.blob.content_type)
  end

  before_validation do
    self.creater_id = request.creater_id if creater_id.nil? && request
  end
end
