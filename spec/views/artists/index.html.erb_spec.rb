require 'rails_helper'

RSpec.describe "artists/index", type: :view do
  before(:each) do
    assign(:artists, [
      Artist.create!(
        name: "Name",
        company: nil
      ),
      Artist.create!(
        name: "Name",
        company: nil
      )
    ])
  end

  it "renders a list of artists" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
