class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :bet_id
      t.integer :user_id
      t.decimal :amount
      t.integer :position

      t.timestamps
    end
  end
end
