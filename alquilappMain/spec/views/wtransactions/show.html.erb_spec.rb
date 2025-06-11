require 'rails_helper'

RSpec.describe "wtransactions/show", type: :view do
  before(:each) do
    assign(:wtransaction, Wtransaction.create!(
      wallet_id: 2,
      card_id: 3,
      balance: 4,
      entry: 5,
      new_balance: "New Balance",
      integer: "Integer"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/New Balance/)
    expect(rendered).to match(/Integer/)
  end
end
