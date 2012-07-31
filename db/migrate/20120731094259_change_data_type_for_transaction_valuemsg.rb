class ChangeDataTypeForTransactionValuemsg < ActiveRecord::Migration
  def up
    change_table :transactions do |t|
      t.change :valueMsg, :text, :limit => nil
    end
  end

  def down
    change_table :transactions do |t|
      t.change :valueMsg, :string
    end
  end
end
