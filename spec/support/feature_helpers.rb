module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    file_in 'Email', with: user.email
    file_in 'Password', with: user.password
    click_on 'Log in'
  end
end
