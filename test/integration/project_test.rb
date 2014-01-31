require 'test_helper'

class Integration::ProjectTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.make!(name: 'John Doe', password: 'pass123worD!')
    @proj = Project.make!(team: @user.team)
  end

  test 'Team Index' do
    other_team = Team.make!
    other_proj = Project.make!(team: other_team)

    login_user(@user)

    visit '/projects'

    binding.pry
    assert page.has_xpath?("//*[@id='project-#{@proj.id}']")
    assert page.has_no_xpath?("//*[@id='project-#{other_proj.id}']")
  end
end
