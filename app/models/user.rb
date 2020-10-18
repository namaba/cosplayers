# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  introduction           :text(65535)
#  is_admin               :boolean          default(FALSE)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  uid                    :string(255)
#  unconfirmed_email      :string(255)
#  unlock_token           :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  has_one_attached :avatar

  has_many :requests
  has_one :creater
  has_one :credit_card

  validate :validate_avatar

  # TODO: 一般ユーザーに公開するときに削除
  after_create do
    self.create_creater(description: '', min_charge: 1000)
  end

  def validate_avatar
    errors.add(:avatar, "画像データではありません。") unless image?
  end

  def image?
    return '' unless avatar.attached?

    %w[image/jpg image/jpeg image/png image/gif].include?(avatar.blob.content_type)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:twitter]

  def self.from_omniauth(auth)
    find_or_initialize_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.password = Devise.friendly_token[0, 20]
      user.email = User.dumy_email(auth)
    end
  end

  def profile_complete?
    introduction && avatar.attached? && creater&.photos&.present?
  end

  private

  def self.dumy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
