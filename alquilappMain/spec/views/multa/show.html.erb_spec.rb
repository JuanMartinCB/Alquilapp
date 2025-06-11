require 'rails_helper'

RSpec.describe "multa/show", type: :view do
  before(:each) do
    assign(:multum, Multum.create!(
      monto: 2,
      razon: "Razon",
      user_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Razon/)
    expect(rendered).to match(/3/)
  end
end
