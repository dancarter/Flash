module AuthenticationHelper
  def login_as(user)
    visit new_user_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Sign in'
  end

  def logout
    visit root_path
    click_on 'Sign Out'
  end
end
