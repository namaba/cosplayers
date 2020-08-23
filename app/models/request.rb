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
#  status       :string(255)      default("offering"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Request < ApplicationRecord

  enum genre: {
    photo: 'photo',
    movie: 'movie',
  }

  enum status: {
    requesting: 'requesting',
    accepted: 'accept',
    canceled: 'canceled',
    declined: 'declined',
    expired: 'expired',
    canceled_by_manage: 'canceled_by_manage'
  }

end
