class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :amount
      t.integer :cc_num
      t.string :exp_date

      t.timestamps
    end
  end
end
