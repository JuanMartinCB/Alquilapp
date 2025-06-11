require 'rails_helper'

RSpec.describe "tickets/show", type: :view do
  before(:each) do
    assign(:ticket, Ticket.create!(
      user_id: 2,
      wt_id: 3,
      rental_id: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
