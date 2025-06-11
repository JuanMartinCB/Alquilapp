require 'rails_helper'

RSpec.describe "cards/show", type: :view do
  before(:each) do
    assign(:card, Card.create!(
      name: "Name",
      number: 2,
      company: 3,
      wallet_id: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
