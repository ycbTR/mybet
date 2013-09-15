require 'spec_helper'

describe "bets/index" do
  before(:each) do
    assign(:bets, [
      stub_model(Bet,
        :name => "Name",
        :original_odds => "9.99",
        :odd_inflation => "9.99",
        :bid_amount => "9.99",
        :description => "MyText"
      ),
      stub_model(Bet,
        :name => "Name",
        :original_odds => "9.99",
        :odd_inflation => "9.99",
        :bid_amount => "9.99",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of bets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
