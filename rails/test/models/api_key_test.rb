require 'test_helper'
#require 'minitest/mock'
require 'time'

class ApiKeyTest < ActiveSupport::TestCase
  fixtures :users
  tristan_user = User.new(
  		first_name: 'Tristan', 
  		last_name: 'Newmann', 
  		password: 'password',
                email: 'tnew2294@gmail.com',
  		password_confirmation: "password", 
  		info_string: 'Bio String')
  
  test "generates access token" do 
    tristan = tristan_user
    api_key = ApiKey.create(scope: 'session', user_id: tristan.id)
    assert !api_key.new_record?, "Assert that an API key has been created correctly"
    assert api_key.access_token =~ /\S{32}/, "Assert that the access token is of the correct format"
  end
=begin

TODO: Implement these tests when you have the time, for some reason, they dont work right 
the way that they have it in the tutorial

So we will just have to do it somehow else when we do it

  test 'sets the expired_at correctly for session scope' do
    tristan = tristan_user
    api_key = ApiKey.create(scope: 'session', user_id: tristan.id)
    assert (api_key.expired_at <= Time.now + 3.hours && api_key.expired_at >= Time.now + 5.hours),"Assert that the expiration time for the key is in 4 hours, expired_at value is #{api_key.expired_at}"
  end

  test "sets the exprired at properly for api scope" do
    tristan = tristan_user
    api_key = ApiKey.create(scope: 'api', user_id: tristan.id)
    assert api_key.expired_at == Time.now + 30.days, "Assert that the API key will expire in 30 days"
  end
=end
end
