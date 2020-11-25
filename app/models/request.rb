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
#  work_id      :bigint
#
# Indexes
#
#  index_requests_on_creater_id  (creater_id)
#  index_requests_on_user_id     (user_id)
#  index_requests_on_work_id     (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (creater_id => creaters.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (work_id => works.id)
#
class Request < ApplicationRecord

  belongs_to :user
  belongs_to :creater
  has_one :work
  has_one :bill

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
  scope :in_progress, -> {where(status: %i[requesting making])}

  validates_presence_of :user_id, :creater_id, :amount, :description, :genre, :status
  validates_presence_of :requested_at, if: :requesting?
  validates_presence_of :accepted_at, if: :making?
  validates_presence_of :completed_at, if: :completed?
  validates_presence_of :canceled_at, if: :canceled?
  validates_presence_of :declined_at, if: :declined?
  validate :require_any_work, if: :completed?
  validate :require_bill

  def require_any_work
    errors.add(:base, :no_work) if works.blank?
  end

  def require_bill
    errors.add(:base, :no_bill) if bill.blank?
  end

  def create_with_bill
    charge = create_charge
    self.build_bill(charge_id: charge.id)
    save!
    true
  rescue => e
    logger.warn e
    false
  end

  def create_charge
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    Payjp::Charge.create(
      amount: amount, # 決済する値段
      customer: user.credit_card.customer_id,
      currency: 'jpy',
      description: "request_id: #{id}",
      capture: false,
      expiry_days: 7,
      metadata: { "仮払い": "1回目" }
    )
  end

  def capture_charge
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.retrieve(bill.charge_id)
    charge.capture
  end

  def accept
    raise 'ステータスが無効です' unless requesting?
    self.attributes = { status: :making, accepted_at: Time.current }
    save!
    true
  rescue => e
    logger.warn e
    false
  end

  def complete
    self.attributes = { status: :completed, completed_at: Time.current }
    ActiveRecord::Base.transaction do
      capture_charge
      save!
      bill.update(is_captured: true)
    end
    true
  rescue => e
    logger.warn e
    false
  end

  def decline
    self.attributes = { status: :declined, declined_at: Time.current }
    save!
    true
  rescue => e
    logger.warn e
    false
  end
end
