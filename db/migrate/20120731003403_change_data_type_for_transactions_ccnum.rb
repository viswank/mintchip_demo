class ChangeDataTypeForTransactionsCcnum < ActiveRecord::Migration
  def up
    change_table :transactions do |t|
      t.change :cc_num, :string
    end
  end

  def down
    change_table :transactions do |t|
      t.change :cc_num, :integer
    end
  end
end
