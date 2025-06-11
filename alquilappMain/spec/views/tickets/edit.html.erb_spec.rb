require 'rails_helper'

RSpec.describe "tickets/edit", type: :view do
  let(:ticket) {
    Ticket.create!(
      user_id: 1,
      wt_id: 1,
      rental_id: 1
    )
  }

  before(:each) do
    assign(:ticket, ticket)
  end

  it "renders the edit ticket form" do
    render

    assert_select "form[action=?][method=?]", ticket_path(ticket), "post" do

      assert_select "input[name=?]", "ticket[user_id]"

      assert_select "input[name=?]", "ticket[wt_id]"

      assert_select "input[name=?]", "ticket[rental_id]"
    end
  end
end
