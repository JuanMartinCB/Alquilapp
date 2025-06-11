require 'rails_helper'

RSpec.describe "rentals/index", type: :view do
  before(:each) do
    assign(:rentals, [
      Rental.create!(
        user_id: 2,
        vehicle_id: 3,
        start_point: "",
        end_point: "",
        state: "State"
      ),
      Rental.create!(
        user_id: 2,
        vehicle_id: 3,
        start_point: "",
        end_point: "",
        state: "State"
      )
    ])
  end

  it "renders a list of rentals" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("State".to_s), count: 2
  end
end
