require 'rails_helper'

RSpec.describe "songs/new", type: :view do
  before(:each) do
    assign(:song, Song.new(
      name: "MyString",
      company: nil,
      album: nil
    ))
  end

  it "renders new song form" do
    render

    assert_select "form[action=?][method=?]", songs_path, "post" do

      assert_select "input[name=?]", "song[name]"

      assert_select "input[name=?]", "song[company_id]"

      assert_select "input[name=?]", "song[album_id]"
    end
  end
end
