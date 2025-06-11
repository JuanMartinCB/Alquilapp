require 'rails_helper'

RSpec.describe "incidents/edit", type: :view do
  let(:incident) {
    Incident.create!(
      user_id: 1,
      vehicle_id: 1,
      description: "MyString"
    )
  }

  before(:each) do
    assign(:incident, incident)
  end

  it "renders the edit incident form" do
    render

    assert_select "form[action=?][method=?]", incident_path(incident), "post" do

      assert_select "input[name=?]", "incident[user_id]"

      assert_select "input[name=?]", "incident[vehicle_id]"

      assert_select "input[name=?]", "incident[description]"
    end
  end
end
