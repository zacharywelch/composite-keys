require 'rails_helper'

RSpec.describe "songs/edit", type: :view do
  let(:song) {
    Song.create!(
      name: "MyString",
      company: nil,
      album: nil
    )
  }

  before(:each) do
    assign(:song, song)
  end

  it "renders the edit song form" do
    render

    assert_select "form[action=?][method=?]", song_path(song), "post" do

      assert_select "input[name=?]", "song[name]"

      assert_select "input[name=?]", "song[company_id]"

      assert_select "input[name=?]", "song[album_id]"
    end
  end
end
