require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do 
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do 
      post users_path, params: {user: { name: "javi", email: "user@invalid", password: "foo", password_confirmation: "foo"}}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path 
    assert_select 'form[action="/signup"]'

    assert_difference "User.count", 1 do 
      post users_path, params: {user: { name: "javillo", email: "javierjaram1@gmail.com", password: "m0bile_qa", password_confirmation: "m0bile_qa"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
