require 'rails_helper'

RSpec.describe "wallets/edit", type: :view do
  let(:wallet) {
    Wallet.create!(
      user_id: 1,
      balance: 1
    )
  }

  before(:each) do
    assign(:wallet, wallet)
  end

  it "renders the edit wallet form" do
    render

    assert_select "form[action=?][method=?]", wallet_path(wallet), "post" do

      assert_select "input[name=?]", "wallet[user_id]"

      assert_select "input[name=?]", "wallet[balance]"
    end
  end
end
