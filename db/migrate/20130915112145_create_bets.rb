class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :name
      t.date :date
      t.decimal :original_odds
      t.decimal :final_odds
      t.decimal :odd_inflation
      t.decimal :bid_amount
      t.text :description
      t.string :state
      t.integer :user_id
      t.integer :last_bidder_id


      t.timestamps
    end
  end
end
