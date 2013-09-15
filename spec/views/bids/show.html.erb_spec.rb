require 'spec_helper'

describe "bids/show" do
  before(:each) do
    @bid = assign(:bid, stub_model(Bid,
      :bet_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
