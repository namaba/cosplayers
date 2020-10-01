# == Schema Information
#
# Table name: requests
#
#  id           :bigint           not null, primary key
#  accepted_at  :datetime
#  amount       :integer          default(0), not null
#  canceled_at  :datetime
#  completed_at :datetime
#  declined_at  :datetime
#  description  :text(65535)      not null
#  expired_at   :datetime
#  genre        :string(255)      default("photo"), not null
#  is_anonymous :boolean          default(FALSE), not null
#  is_hidden    :boolean          default(FALSE), not null
#  requested_at :datetime
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
  has_one :bill

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

  def create_charge
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
    self.create_bill(charge_id: charge.id)
  end

  def capture_charge
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.retrieve(bill.charge_id)
    charge.capture
    bill.update(is_captured: true)
  end
end
