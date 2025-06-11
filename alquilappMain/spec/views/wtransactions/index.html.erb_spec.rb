require 'rails_helper'

RSpec.describe "wtransactions/index", type: :view do
  before(:each) do
    assign(:wtransactions, [
      Wtransaction.create!(
        wallet_id: 2,
        card_id: 3,
        balance: 4,
        entry: 5,
        new_balance: "New Balance",
        integer: "Integer"
      ),
      Wtransaction.create!(
        wallet_id: 2,
        card_id: 3,
        balance: 4,
        entry: 5,
        new_balance: "New Balance",
        integer: "Integer"
      )
    ])
  end

  it "renders a list of wtransactions" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("New Balance".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Integer".to_s), count: 2
  end
end
