require 'test_helper'

class Integration::TaskTest < ActionDispatch::IntegrationTest
  setup do
    @user_a = User.make!(name: 'John Doe', password: 'pass123worD!')
    @user_b = User.make!(name: 'Jane Doe', password: 'pass123worD!')
  end

  test 'Task Index' do
    project_a = Project.make!(team: @user_a.team, )
    project_b = Project.make!(team: @user_b.team, )

    10.times { Task.make!(project: project_a) }
    10.times { Task.make!(project: project_b) }

    login_user(@user_a)

    visit '/tasks'
    Task.all.each do |task|
      assert page.has_xpath?("//*[@id='task-#{task.id}']")
    end
  end
end
