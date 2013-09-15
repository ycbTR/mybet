require 'spec_helper'

describe "bids/edit" do
  before(:each) do
    @bid = assign(:bid, stub_model(Bid,
      :bet_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit bid form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bid_path(@bid), "post" do
      assert_select "input#bid_bet_id[name=?]", "bid[bet_id]"
      assert_select "input#bid_user_id[name=?]", "bid[user_id]"
    end
  end
end
