require 'rails_helper'

RSpec.describe "cards/new", type: :view do
  before(:each) do
    assign(:card, Card.new(
      name: "MyString",
      number: 1,
      company: 1,
      wallet_id: 1
    ))
  end

  it "renders new card form" do
    render

    assert_select "form[action=?][method=?]", cards_path, "post" do

      assert_select "input[name=?]", "card[name]"

      assert_select "input[name=?]", "card[number]"

      assert_select "input[name=?]", "card[company]"

      assert_select "input[name=?]", "card[wallet_id]"
    end
  end
end
