require 'rails_helper'

RSpec.describe "wallets/index", type: :view do
  before(:each) do
    assign(:wallets, [
      Wallet.create!(
        user_id: 2,
        balance: 3
      ),
      Wallet.create!(
        user_id: 2,
        balance: 3
      )
    ])
  end

  it "renders a list of wallets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
