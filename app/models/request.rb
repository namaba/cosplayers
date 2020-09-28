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
class Request < ApplicationRecord

  belongs_to :user
  belongs_to :creater

  has_many :works, dependent: :nullify
  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true

  enum genre: {
    photo: 'photo',
    movie: 'movie',
  }

  enum status: {
    requesting: 'requesting',
    making: 'making',
    completed: 'completed',
    canceled: 'canceled',
    declined: 'declined',
    expired: 'expired',
    canceled_by_manage: 'canceled_by_manage'
  }

  scope :all_canceled, -> { where(status: %i[canceled declined canceled_by_manage]) }

  def pay
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.create(
      amount: amount, # 決済する値段
      customer: user.credit_card.customer_id,
      currency: 'jpy',
      description: "request_id: #{id}",
      capture: false,
      expiry_days: 7,
      metadata: {"仮払い": "1回目"}
    )
  end
end
