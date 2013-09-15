require 'spec_helper'

describe "bids/new" do
  before(:each) do
    assign(:bid, stub_model(Bid,
      :bet_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new bid form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bids_path, "post" do
      assert_select "input#bid_bet_id[name=?]", "bid[bet_id]"
      assert_select "input#bid_user_id[name=?]", "bid[user_id]"
    end
  end
end
