require 'rails_helper'

RSpec.describe "tickets/index", type: :view do
  before(:each) do
    assign(:tickets, [
      Ticket.create!(
        user_id: 2,
        wt_id: 3,
        rental_id: 4
      ),
      Ticket.create!(
        user_id: 2,
        wt_id: 3,
        rental_id: 4
      )
    ])
  end

  it "renders a list of tickets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
  end
end
