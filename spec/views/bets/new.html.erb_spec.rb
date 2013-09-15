require 'spec_helper'

describe "bets/new" do
  before(:each) do
    assign(:bet, stub_model(Bet,
      :name => "MyString",
      :original_odds => "9.99",
      :odd_inflation => "9.99",
      :bid_amount => "9.99",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new bet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bets_path, "post" do
      assert_select "input#bet_name[name=?]", "bet[name]"
      assert_select "input#bet_original_odds[name=?]", "bet[original_odds]"
      assert_select "input#bet_odd_inflation[name=?]", "bet[odd_inflation]"
      assert_select "input#bet_bid_amount[name=?]", "bet[bid_amount]"
      assert_select "textarea#bet_description[name=?]", "bet[description]"
    end
  end
end
