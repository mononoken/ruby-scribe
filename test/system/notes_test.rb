require "mobile_system_test_case"

class NotesTest < MobileSystemTestCase
  # test "should be able to create Note" do
  #   visit notes_path
  #
  #   click_on "New Article"
  #
  #   fill_in "Title", with: ""
  #   fill_in "Body", with: ""
  #
  #   click_on "Create Article"
  #
  #   assert_text "Creating an Article"
  # end

  test "should force user to login to see notes" do
    sign_out :user

    visit notes_path

    assert_selector :label, text: "Sign in"
  end
end
