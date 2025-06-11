require 'rails_helper'

RSpec.describe "multa/index", type: :view do
  before(:each) do
    assign(:multa, [
      Multum.create!(
        monto: 2,
        razon: "Razon",
        user_id: 3
      ),
      Multum.create!(
        monto: 2,
        razon: "Razon",
        user_id: 3
      )
    ])
  end

  it "renders a list of multa" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Razon".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
