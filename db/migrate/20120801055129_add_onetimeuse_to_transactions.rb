class AddOnetimeuseToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :onetimeuse, :integer
  end
end
