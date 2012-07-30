class AddCardTypeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :cardType, :integer
  end
end
