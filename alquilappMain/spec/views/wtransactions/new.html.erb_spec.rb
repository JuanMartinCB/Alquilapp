require 'rails_helper'

RSpec.describe "wtransactions/new", type: :view do
  before(:each) do
    assign(:wtransaction, Wtransaction.new(
      wallet_id: 1,
      card_id: 1,
      balance: 1,
      entry: 1,
      new_balance: "MyString",
      integer: "MyString"
    ))
  end

  it "renders new wtransaction form" do
    render

    assert_select "form[action=?][method=?]", wtransactions_path, "post" do

      assert_select "input[name=?]", "wtransaction[wallet_id]"

      assert_select "input[name=?]", "wtransaction[card_id]"

      assert_select "input[name=?]", "wtransaction[balance]"

      assert_select "input[name=?]", "wtransaction[entry]"

      assert_select "input[name=?]", "wtransaction[new_balance]"

      assert_select "input[name=?]", "wtransaction[integer]"
    end
  end
end
