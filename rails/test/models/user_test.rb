require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(
  		fName: 'Tristan', 
  		lName: 'Newmann', 
  		password: 'password',
  		password_confirmation: "password", 
  		infoString: 'Bio String')
  end

  test 'should be valid' do
	assert @user.valid?  	
  end

  test 'first name should be present' do
  	@user.fName = "     "
  	assert_not @user.valid?
  end

  test 'last name should be present' do
  	@user.lName = "     "
  	assert_not @user.valid?
  end

  test 'fName not exceed char limit' do
  	@user.fName = "a" * 255
  	assert_not @user.valid?
  end

end
