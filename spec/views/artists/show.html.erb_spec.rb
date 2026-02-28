require 'rails_helper'

RSpec.describe "artists/show", type: :view do
  before(:each) do
    assign(:artist, Artist.create!(
      name: "Name",
      company: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
