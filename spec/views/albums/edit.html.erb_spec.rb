require 'rails_helper'

RSpec.describe "albums/edit", type: :view do
  let(:album) {
    Album.create!(
      name: "MyString",
      company: nil,
      artist: nil
    )
  }

  before(:each) do
    assign(:album, album)
  end

  it "renders the edit album form" do
    render

    assert_select "form[action=?][method=?]", album_path(album), "post" do

      assert_select "input[name=?]", "album[name]"

      assert_select "input[name=?]", "album[company_id]"

      assert_select "input[name=?]", "album[artist_id]"
    end
  end
end
