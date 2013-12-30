module AuthenticationHelper
  class << self
    def sign_in_as(user)
      visit '/'
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end

    def sign_out
      visit root_path
      click_on 'Sign Out'
    end
  end
end
