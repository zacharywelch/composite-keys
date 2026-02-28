require 'rails_helper'

RSpec.describe "artists/edit", type: :view do
  let(:artist) {
    Artist.create!(
      name: "MyString",
      company: nil
    )
  }

  before(:each) do
    assign(:artist, artist)
  end

  it "renders the edit artist form" do
    render

    assert_select "form[action=?][method=?]", artist_path(artist), "post" do

      assert_select "input[name=?]", "artist[name]"

      assert_select "input[name=?]", "artist[company_id]"
    end
  end
end
