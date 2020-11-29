# == Schema Information
#
# Table name: creaters
#
#  id             :bigint           not null, primary key
#  description    :text(65535)
#  identification :string(191)      default("unidentified"), not null
#  is_accepting   :boolean          default(TRUE), not null
#  min_charge     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_creaters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class CreaterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
