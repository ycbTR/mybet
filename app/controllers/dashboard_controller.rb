class DashboardController < ApplicationController
  before_filter :only_admin

  def index
    @bets = Bet.where("state != 'new'")
  end


  def update
    @bet = Bet.find(params[:id])
    @bet.send(params[:e].to_sym)
  end

  def reporting
    @bets = Bet.won_or_lost
  end
end