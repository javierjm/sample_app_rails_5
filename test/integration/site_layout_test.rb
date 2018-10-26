require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @name  = "Foo Bar"
    @email = "foo@bar.com"
  end

  test "layout links" do
    # Get the root path (Home page).
    get root_path
    # Verify that the right page template is rendered.
    assert_template 'static_pages/home'
    # Check for the correct links to the Home, Help, About, and Contact pages.
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")
    end

  test "Not logged in user is redirected to login when clicking users" do
    # Get the root path (Home page).
    get root_path
    assert_template 'static_pages/home'
    get users_path
    assert_redirected_to login_path
  end

   test "Logged in user is able to see users" do
    log_in_as @user
    # Get the root path (Home page).
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", users_path
    get users_path
  end
end
