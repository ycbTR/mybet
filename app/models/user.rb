class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_many :bets
  has_many :bids


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  attr_accessor :login
  validates_presence_of :username
  validates_uniqueness_of :username

  attr_accessible :login

  before_create :set_role

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      where(conditions).first
    end
  end


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role


  def has_role?(val)
    self.role == val
  end


  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def bets_as_last_person
    self.bids.joins(:bet).where("#{Bet.table_name}.last_bidder_id = ?", self.id).map(&:bet).uniq
  end

  def live_bets_as_bidder
    self.bids.joins(:bet).where("#{Bet.table_name}.state = ?", 'pending').map(&:bet).uniq
  end

  def won_bets_as_bidder
    self.bids.joins(:bet).where("#{Bet.table_name}.state = ?", 'won').map(&:bet).uniq
  end

  def won_payout
    self.won_bets_as_bidder.map(&:potential_payout).sum rescue 0
  end

  def spent_on_bidding
    self.bids.sum(:amount)
  end

  def balance
    won_payout - spent_on_bidding
  end

  def past_bets_as_bidder
    self.bids.joins(:bet).where("#{Bet.table_name}.state IN(?)", ['won', 'lost']).map(&:bet).uniq
  end

  private

  def set_role
    self.role ||= "standard"
  end

end
