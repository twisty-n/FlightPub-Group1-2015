require 'test_helper'

class Api::SessionControllerTest < ActionController::TestCase
    test "Authenticate with email" do
        password = 'password'
        tristan = User.create(  email: 'joe@blogs.com', password: password, password_confirmation: password)
        post 'create', { email: tristan.email, password: password }
        results = JSON.parse(response.body)
        Rails.logger.debug(results)
        assert results['api_key'], 'No result body, due to 401 error'
        assert results['api_key']['access_token'] =~ /\S{32}/
        assert results['api_key']['user_id'] == tristan.id
    end

    test "Authenticate with invalid information" do
        password = 'terrible'
        not_password ='gas'
        tristan = User.create(  email: 'joe@blogs.com', 
                                password: password,
                                password_confirmation: password)
        post 'create', { email: tristan.email, password: not_password }
        assert response.status == 401
    end
end
