class ChangeDataTypeForTransactionCcnum1 < ActiveRecord::Migration
  def up
    change_table :transactions do |t|
      t.change :cc_num, :text, :limit => nil
    end
  end

  def down
    change_table :transactions do |t|
      t.change :cc_num, :string
    end
  end
end
