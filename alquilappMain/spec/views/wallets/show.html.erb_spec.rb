require 'rails_helper'

RSpec.describe "wallets/show", type: :view do
  before(:each) do
    assign(:wallet, Wallet.create!(
      user_id: 2,
      balance: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
