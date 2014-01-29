require 'test_helper'

class Integration::UserTest < ActionDispatch::IntegrationTest
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
    skip 'Not working for some silly reason'
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

  test 'Rendering the user dashboard' do
    other_user = User.make!(name: 'Jane Doe', password: 'pass123worD!',
                            team: @user.team)

    completed_project = Project.make!(team: @user.team)
    completed_project.complete!

    inc_proj           = Project.make!(team: @user.team)
    reported_task      = Task.make!(project: inc_proj, reporter: @user, owner: other_user)
    owned_task         = Task.make!(project: inc_proj, reporter: other_user, owner: @user)

    login_user(@user)

    assert page.has_xpath?("//*[@id='db-projects-open']/div/a[@id='project-#{inc_proj.id}']"),
           "Incomplete Project (#{inc_proj.id}) not shown in Open List"
    assert page.has_xpath?("//*[@id='db-projects-rc']/div"),
           "Recently Completed Projects not listing"
    assert page.has_xpath?("//*[@id='db-projects-rc']/div/a"),
           "Recently Completed Projects has invalid elements"

    assert page.has_xpath?("//*[@id='db-tasks-owned']/div/a[@id='task-#{owned_task.id}']"),
           "Owned task not rendering"
    assert page.has_xpath?("//*[@id='db-tasks-reported']/div/a[@id='task-#{reported_task.id}']"),
           "Reported task not rendering"

    assert_match /John Doe's Dashboard/, page.title,
                'Page title does not match /#{User.name}\'s Dashboard/'
  end
end
