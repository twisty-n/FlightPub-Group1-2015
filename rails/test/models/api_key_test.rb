require 'test_helper'
require 'minitest/mock'

class ApiKeyTest < ActiveSupport::TestCase
  tristan_id = 1
  
  test "generates access token" do 
    tristan = Users.find(tristan_id)
    api_key = ApiKey.create(scope: 'session', user_id: tristan.id)
    assert !api_key.new_record?
    assert api_key.access_token =~ /\s{32}/
  end

  test 'sets the expired_at correctly for session scope' do
    Time.stub :now, Time.at(0) do
      tristan = Users.find(1)
      api_key = ApiKey.create(scope: 'session', user_id: tristan.id)
      assert api_key.expired_at == 4.hours.from.now
    end
  end

  test "sets the exprired at properly for api scope" do
    Time.stub :now, Time.at(0) do
      tristan = Users.find(tristan_id)
      api_key = ApiKey.create(scope: 'api', user_id: tristan.id)
      assert api_key.expired_at == 30.days.from.now
    end
  end
end
