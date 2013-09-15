require 'spec_helper'

describe "bets/show" do
  before(:each) do
    @bet = assign(:bet, stub_model(Bet,
      :name => "Name",
      :original_odds => "9.99",
      :odd_inflation => "9.99",
      :bid_amount => "9.99",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/MyText/)
  end
end
