require 'rails_helper'

RSpec.describe "multa/new", type: :view do
  before(:each) do
    assign(:multum, Multum.new(
      monto: 1,
      razon: "MyString",
      user_id: 1
    ))
  end

  it "renders new multum form" do
    render

    assert_select "form[action=?][method=?]", multa_path, "post" do

      assert_select "input[name=?]", "multum[monto]"

      assert_select "input[name=?]", "multum[razon]"

      assert_select "input[name=?]", "multum[user_id]"
    end
  end
end
