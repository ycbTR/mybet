class Bid < ActiveRecord::Base

  belongs_to :bet
  belongs_to :user
  before_create :set_amount
  after_create :set_last_bidder

  private

  def set_amount
    self.position = (bet.bids.count + 1) #TODO do I need to add '+1' ?
    self.amount = self.bet.bid_amount * self.position
  end


  def set_last_bidder
    self.bet.update_attribute("last_bidder_id", self.user_id)
  end
end
