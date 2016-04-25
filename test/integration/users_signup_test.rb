require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup info" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "",
                              email: "user@invalid",
                              password: "444",
                              password_confirmation: "4444"}
    end
    assert_template 'users/new'
    #assert_select 'div#<>'
    #assert_select 'div.<CSS class for field with error>'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
    post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
