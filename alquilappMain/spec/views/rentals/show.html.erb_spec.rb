require 'rails_helper'

RSpec.describe "rentals/show", type: :view do
  before(:each) do
    assign(:rental, Rental.create!(
      user_id: 2,
      vehicle_id: 3,
      start_point: "",
      end_point: "",
      state: "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/State/)
  end
end
