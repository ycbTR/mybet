class DashboardController < ApplicationController
  before_filter :only_admin

  def index
    @bets = Bet.where("state != 'new'")

    if params[:state]
      @bets = @bets.where(:state => params[:state])
    end
    @options = [
        ["All Bets", root_path],
        ["Won Bets", root_path(:state => "won")],
        ["Lost Bets", root_path(:state => "lost")],
        ["Pending Bets", root_path(:state => "pending")]
    ]
  end


  def update
    @bet = Bet.find(params[:id])
    @bet.send(params[:e].to_sym)
  end

  def reporting
    @bets = Bet.won_or_lost
  end
end