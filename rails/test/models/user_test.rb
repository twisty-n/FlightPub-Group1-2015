require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(
  		first_name: 'Tristan', 
  		last_name: 'Newmann', 
  		password: 'password',
                email: 'tnew2294@gmail.com',
                email_confirmation: 'tnew2294@gmail.com',
  		password_confirmation: "password", 
  		info_string: 'Bio String')
  end

  test 'should be valid' do
	assert @user.valid?  	
  end

  test 'first name should be present' do
  	@user.first_name = "     "
  	assert_not @user.valid?
  end

  test 'last name should be present' do
  	@user.last_name = "     "
  	assert_not @user.valid?
  end

  test 'fName not exceed char limit' do
  	@user.first_name = "a" * 255
  	assert_not @user.valid?
  end

end
