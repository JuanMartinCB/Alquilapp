require 'rails_helper'

RSpec.describe "cards/edit", type: :view do
  let(:card) {
    Card.create!(
      name: "MyString",
      number: 1,
      company: 1,
      wallet_id: 1
    )
  }

  before(:each) do
    assign(:card, card)
  end

  it "renders the edit card form" do
    render

    assert_select "form[action=?][method=?]", card_path(card), "post" do

      assert_select "input[name=?]", "card[name]"

      assert_select "input[name=?]", "card[number]"

      assert_select "input[name=?]", "card[company]"

      assert_select "input[name=?]", "card[wallet_id]"
    end
  end
end
