require 'rails_helper'

RSpec.describe "incidents/index", type: :view do
  before(:each) do
    assign(:incidents, [
      Incident.create!(
        user_id: 2,
        vehicle_id: 3,
        description: "Description"
      ),
      Incident.create!(
        user_id: 2,
        vehicle_id: 3,
        description: "Description"
      )
    ])
  end

  it "renders a list of incidents" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
  end
end
