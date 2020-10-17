# == Schema Information
#
# Table name: creaters
#
#  id           :bigint           not null, primary key
#  description  :text(65535)
#  is_accepting :boolean          default(TRUE), not null
#  min_charge   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_creaters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Creater < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_many :bills, through: :requests
  has_many :works, dependent: :nullify
  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true
  has_many :photos, through: :works
end
