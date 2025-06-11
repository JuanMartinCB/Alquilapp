require 'rails_helper'

RSpec.describe "rentals/edit", type: :view do
  let(:rental) {
    Rental.create!(
      user_id: 1,
      vehicle_id: 1,
      start_point: "",
      end_point: "",
      state: "MyString"
    )
  }

  before(:each) do
    assign(:rental, rental)
  end

  it "renders the edit rental form" do
    render

    assert_select "form[action=?][method=?]", rental_path(rental), "post" do

      assert_select "input[name=?]", "rental[user_id]"

      assert_select "input[name=?]", "rental[vehicle_id]"

      assert_select "input[name=?]", "rental[start_point]"

      assert_select "input[name=?]", "rental[end_point]"

      assert_select "input[name=?]", "rental[state]"
    end
  end
end
