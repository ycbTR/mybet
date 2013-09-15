class BetsController < ApplicationController
  # GET /bets
  # GET /bets.json
  before_filter :only_admin, :except => [:bid, :pending]

  def index
    redirect_to root_path and return

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bets }
    end
  end

  def pending
    @bets = Bet.where(:state => "pending")
  end


  def bid
    @bet = Bet.find(params[:id])
    @bet.bid!(current_user)
    redirect_to request.referer || pending_bets_path
  end


  # GET /bets/1
  # GET /bets/1.json
  def show

    @bet = Bet.find(params[:id])


    redirect_to root_path and return unless @bet.new?
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bet }
    end
  end

  # GET /bets/new
  # GET /bets/new.json
  def new
    @bet = Bet.new(:odd_inflation => 10, :bid_amount => 1)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bet }
    end
  end

  # GET /bets/1/edit
  def edit
    @bet = Bet.find(params[:id])
  end

  # POST /bets
  # POST /bets.json
  def create
    @bet = Bet.new(params[:bet])

    respond_to do |format|
      if @bet.save
        format.html { redirect_to @bet, notice: 'Bet was successfully created.' }
        format.json { render json: @bet, status: :created, location: @bet }
      else
        format.html { render action: "new" }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bets/1
  # PUT /bets/1.json
  def update
    @bet = Bet.find(params[:id])

    respond_to do |format|
      if @bet.update_attributes(params[:bet])
        format.html { redirect_to @bet, notice: 'Bet was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bets/1
  # DELETE /bets/1.json
  def destroy
    @bet = Bet.find(params[:id])
    @bet.destroy
    flash[:success] = "Successfully deleted!"
    respond_to do |format|
      format.html { redirect_to bets_url }
      format.js { render 'destroy' }
      format.json { head :ok }
    end
  end
end
