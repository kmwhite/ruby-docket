require 'test_helper'

class Integration::ProjectTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.make!(name: 'John Doe', password: 'pass123worD!')
    @proj = Project.make!(team: @user.team)
  end

  test 'Project Index' do
    other_team = Team.make!
    other_proj = Project.make!(team: other_team)

    login_user(@user)

    visit '/projects'

    assert page.has_xpath?("//*[@id='project-#{@proj.id}']")
    assert page.has_no_xpath?("//*[@id='project-#{other_proj.id}']")
  end

  test 'Project Show' do
    other_proj = Project.make!(team: @user.team)

    proj_tasks = Array.new(10).map { Task.make!(project: @proj, reporter: @user) }
    other_proj_tasks = Array.new(10) { Task.make!(project: other_proj, reporter: @user) }

    login_user(@user)
    visit "/projects/#{@proj.id}"
    proj_tasks.each do |task|
      assert page.has_xpath?("//*[@id='task-#{task.id}']")
    end

    visit "/projects/#{other_proj.id}"
    other_proj_tasks.each do |task|
      assert page.has_xpath?("//*[@id='task-#{task.id}']")
    end
  end
end
