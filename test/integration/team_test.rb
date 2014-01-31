require 'test_helper'

class Integration::TeamTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.make!(name: 'John Doe', password: 'pass123worD!')
  end

  test 'Team Index' do
    login_user(@user)

    visit '/teams'

    assert page.has_xpath?("//*[@id='team-#{@user.team.id}']")
  end
end
