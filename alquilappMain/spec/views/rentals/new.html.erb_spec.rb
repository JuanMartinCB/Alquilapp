require 'rails_helper'

RSpec.describe "rentals/new", type: :view do
  before(:each) do
    assign(:rental, Rental.new(
      user_id: 1,
      vehicle_id: 1,
      start_point: "",
      end_point: "",
      state: "MyString"
    ))
  end

  it "renders new rental form" do
    render

    assert_select "form[action=?][method=?]", rentals_path, "post" do

      assert_select "input[name=?]", "rental[user_id]"

      assert_select "input[name=?]", "rental[vehicle_id]"

      assert_select "input[name=?]", "rental[start_point]"

      assert_select "input[name=?]", "rental[end_point]"

      assert_select "input[name=?]", "rental[state]"
    end
  end
end
