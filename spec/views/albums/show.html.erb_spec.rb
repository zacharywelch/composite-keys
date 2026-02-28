require 'rails_helper'

RSpec.describe "albums/show", type: :view do
  before(:each) do
    assign(:album, Album.create!(
      name: "Name",
      company: nil,
      artist: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
