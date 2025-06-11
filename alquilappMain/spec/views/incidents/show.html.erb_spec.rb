require 'rails_helper'

RSpec.describe "incidents/show", type: :view do
  before(:each) do
    assign(:incident, Incident.create!(
      user_id: 2,
      vehicle_id: 3,
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Description/)
  end
end
