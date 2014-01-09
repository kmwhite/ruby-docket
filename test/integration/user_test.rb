require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.make!(name: 'John Doe', password: 'pass123worD!')
  end

  test 'User login' do
    login_user(@user)
    assert_match current_path, '/'
    assert_match /Signed in successfully/, page.body
  end

  test 'New account registration' do
    team = Team.make!
    visit new_user_registration_path
    fill_in 'user_name', with: 'John Doe'
    fill_in 'user_email', with: 'johndoe@example.com'
    fill_in 'user_password', with: 'pass123worD!'
    fill_in 'user_password_confirmation', with: 'pass123worD!'
    select team.name, from: 'user_team_id'
    click_button 'Sign up'
    
    assert_match current_path, '/'
    assert_match /Welcome! You have signed up successfully/, page.body
  end

  test 'Editing an account' do
    login_user(@user)
    click_link 'John Doe'
    fill_in 'user_name', with: 'Jane Doe'
    fill_in 'user_current_password', with: 'pass123worD!'
    click_button 'Update'
    assert_match /You updated your account successfully/, page.body
    assert_match /Jane Doe/, page.body
  end

  test 'Closing an account' do
    login_user(@user)
    click_link 'John Doe'
    assert_difference 'User.count', -1 do
      click_button 'Cancel my account'
    end
  end
end
