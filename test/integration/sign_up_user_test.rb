require 'test_helper'

class SignUpUserTest < ActionDispatch::IntegrationTest
  test 'can sign up' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path params: { user: { username: 'gabi', email: 'gab@example.com', password: 'password' } }
      follow_redirect!
    end
    user = User.last
    assert_equal session[:user_id], user.id
    assert_template 'users/show'
    assert_response :success
    assert_select 'h4', text: "gabi's articles"
  end
end
