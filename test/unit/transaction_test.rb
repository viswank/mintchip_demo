# == Schema Information
#
# Table name: transactions
#
#  id         :integer         not null, primary key
#  amount     :float
#  cc_num     :text
#  exp_date   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  valueMsg   :text
#  cardType   :integer
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
