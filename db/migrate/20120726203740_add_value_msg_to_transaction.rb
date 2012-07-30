class AddValueMsgToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :valueMsg, :string
  end
end
