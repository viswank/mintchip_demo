# == Schema Information
#
# Table name: transactions
#
#  id         :integer         not null, primary key
#  amount     :float
#  cc_num     :integer
#  exp_date   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  valueMsg   :string(255)
#  cardType   :integer
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
