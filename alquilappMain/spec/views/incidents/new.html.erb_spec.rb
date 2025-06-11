require 'rails_helper'

RSpec.describe "incidents/new", type: :view do
  before(:each) do
    assign(:incident, Incident.new(
      user_id: 1,
      vehicle_id: 1,
      description: "MyString"
    ))
  end

  it "renders new incident form" do
    render

    assert_select "form[action=?][method=?]", incidents_path, "post" do

      assert_select "input[name=?]", "incident[user_id]"

      assert_select "input[name=?]", "incident[vehicle_id]"

      assert_select "input[name=?]", "incident[description]"
    end
  end
end
