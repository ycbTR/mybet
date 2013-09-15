class Bet < ActiveRecord::Base

  has_many :bids
  belongs_to :user
  validates :name, :date, :odd_inflation, :original_odds, :bid_amount, :presence => true
  before_save :do_calculations
  before_create :set_user_id

  state_machine :state, :initial => :new do

    event :confirm do
      transition :from => :new, :to => :pending
    end

    event :won do
      transition :from => :pending, :to => :won
    end

    event :lost do
      transition :from => :pending, :to => :lost
    end

    event :back_to_pending do
      transition :from => :won, :to => :pending
      transition :from => :lost, :to => :pending

    end
  end


  def self.won_or_lost
    where(:state => ["won", "lost"])
  end

  # it gets next possible authorized events of current state
  def next_state_events

    t = self.state_transitions(:from => self.state.to_sym)
    authorized_events = Array.new

    t.each do |transition|
      #if (is_authorized_event?(transition.event.to_s, user.role.name, self.state))
      authorized_events << transition
      #end
    end
    authorized_events
  end

  def locked?
    ["won", "lost"].includes?(self.state)
  end


  def bid_amount_of_person(user)
    self.bids.where(:user_id => user.id).sum(:amount)
  end

  def is_last_person?(user)
    self.last_bidder_id == user.id
  end

  def potential_payout
    self.bids.count * self.bid_amount * final_odds
  end

  def gross_bet_earnings
    case self.state
      when "won"
        2
        (current_bid_price * self.final_odds) - (self.bid_amount_earned)
      when "lost"
        bid_amount_earned
    end
  end


  def current_bid_price
    (self.bids.count + 1) * self.bid_amount
  end

  def bid!(current_user = "")
    self.bids.create(:user_id => current_user.id, :amount => current_bid_price)
  end

  def bid_amount_earned
    self.bids.sum(:amount) + self.bid_amount rescue self.bid_amount
  end

  def sum_amount_of_bids
    self.bids.sum(:amount)
  end

  private

  def do_calculations
    set_final_odds
  end

  def set_final_odds

    if original_odds < 0
      self.final_odds = (-100/original_odds) * odd_inflation
    else
      self.final_odds = (original_odds/100) * odd_inflation
    end

  end


  def set_user_id
    self.user_id = User.current.try(:id)
  end

end
