require 'rails_helper'

RSpec.describe "wallets/new", type: :view do
  before(:each) do
    assign(:wallet, Wallet.new(
      user_id: 1,
      balance: 1
    ))
  end

  it "renders new wallet form" do
    render

    assert_select "form[action=?][method=?]", wallets_path, "post" do

      assert_select "input[name=?]", "wallet[user_id]"

      assert_select "input[name=?]", "wallet[balance]"
    end
  end
end
