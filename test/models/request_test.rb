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
require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
