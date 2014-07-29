class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.integer "amount"
    	t.string "lender"
    	t.string "receiver"
    	t.string "details"
    	t.date "date"
      t.timestamps
    end
  end
end
