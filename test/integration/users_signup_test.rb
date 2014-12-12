require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "Invalid entry data should not create new user." do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert' # alert-danger didn't work
  end

  test "valid entries should create new user" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name: "Russell Crowe",
                                            email: "valid@email.com",
                                            password: "giggidy",
                                            password_confirmation: 'giggidy' }
    end
    # assert_template 'users/show'
    # assert_not flash.nil?
    # assert is_logged_in?
  end


end
