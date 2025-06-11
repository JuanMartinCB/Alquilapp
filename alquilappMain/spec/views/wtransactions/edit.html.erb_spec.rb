require 'rails_helper'

RSpec.describe "wtransactions/edit", type: :view do
  let(:wtransaction) {
    Wtransaction.create!(
      wallet_id: 1,
      card_id: 1,
      balance: 1,
      entry: 1,
      new_balance: "MyString",
      integer: "MyString"
    )
  }

  before(:each) do
    assign(:wtransaction, wtransaction)
  end

  it "renders the edit wtransaction form" do
    render

    assert_select "form[action=?][method=?]", wtransaction_path(wtransaction), "post" do

      assert_select "input[name=?]", "wtransaction[wallet_id]"

      assert_select "input[name=?]", "wtransaction[card_id]"

      assert_select "input[name=?]", "wtransaction[balance]"

      assert_select "input[name=?]", "wtransaction[entry]"

      assert_select "input[name=?]", "wtransaction[new_balance]"

      assert_select "input[name=?]", "wtransaction[integer]"
    end
  end
end
