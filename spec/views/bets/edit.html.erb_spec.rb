require 'spec_helper'

describe "bets/edit" do
  before(:each) do
    @bet = assign(:bet, stub_model(Bet,
      :name => "MyString",
      :original_odds => "9.99",
      :odd_inflation => "9.99",
      :bid_amount => "9.99",
      :description => "MyText"
    ))
  end

  it "renders the edit bet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bet_path(@bet), "post" do
      assert_select "input#bet_name[name=?]", "bet[name]"
      assert_select "input#bet_original_odds[name=?]", "bet[original_odds]"
      assert_select "input#bet_odd_inflation[name=?]", "bet[odd_inflation]"
      assert_select "input#bet_bid_amount[name=?]", "bet[bid_amount]"
      assert_select "textarea#bet_description[name=?]", "bet[description]"
    end
  end
end
