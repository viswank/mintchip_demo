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
#  onetimeuse :integer
#

class Transaction < ActiveRecord::Base
  attr_accessible :amount, :cc_num, :exp_date, :valueMsg, :cardType, :onetimeuse
  
  validates :amount, presence: true
  validates_numericality_of :amount, :greater_than => 0
  validates :valueMsg, presence: true
  
  
end

