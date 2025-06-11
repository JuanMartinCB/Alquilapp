require 'rails_helper'

RSpec.describe "multa/edit", type: :view do
  let(:multum) {
    Multum.create!(
      monto: 1,
      razon: "MyString",
      user_id: 1
    )
  }

  before(:each) do
    assign(:multum, multum)
  end

  it "renders the edit multum form" do
    render

    assert_select "form[action=?][method=?]", multum_path(multum), "post" do

      assert_select "input[name=?]", "multum[monto]"

      assert_select "input[name=?]", "multum[razon]"

      assert_select "input[name=?]", "multum[user_id]"
    end
  end
end
