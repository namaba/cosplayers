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
class Work < ApplicationRecord
  has_one_attached :photo

  belongs_to :creater
  belongs_to :request

  validates_presence_of :creater_id
  validate :validate_photo

  def validate_photo
    errors.add(:photo, "画像データではありません。jpg/jpeg/png/gifのみアップロード可能です") unless image?
  end

  def image?
    return '' unless photo.attached?

    %w[image/jpg image/jpeg image/png image/gif].include?(photo.blob.content_type)
  end


  enum genre: {
    photo: 'photo',
    movie: 'movie',
  }

  before_validation do
    self.creater_id = request.creater_id if creater_id.nil? && request
  end
end
