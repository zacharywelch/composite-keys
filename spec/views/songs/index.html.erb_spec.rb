require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before(:each) do
    assign(:songs, [
      Song.create!(
        name: "Name",
        company: nil,
        album: nil
      ),
      Song.create!(
        name: "Name",
        company: nil,
        album: nil
      )
    ])
  end

  it "renders a list of songs" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
