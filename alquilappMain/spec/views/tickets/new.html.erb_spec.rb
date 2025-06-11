require 'rails_helper'

RSpec.describe "tickets/new", type: :view do
  before(:each) do
    assign(:ticket, Ticket.new(
      user_id: 1,
      wt_id: 1,
      rental_id: 1
    ))
  end

  it "renders new ticket form" do
    render

    assert_select "form[action=?][method=?]", tickets_path, "post" do

      assert_select "input[name=?]", "ticket[user_id]"

      assert_select "input[name=?]", "ticket[wt_id]"

      assert_select "input[name=?]", "ticket[rental_id]"
    end
  end
end
