require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase

    test '#create' do
        post 'create', {
            user: {
                email: 'charlie@unicron.com',
                email_confirmation: 'charlie@unicron.com',
                password: 'password',
                password_confirmation: 'password'
            }
        }
        results = JSON.parse(response.body)
        assert results['api_key']['access_token'] =~ /\S{32}/
        assert results['api_key']['user_id'] > 0
    end

    test '#create with invalid data' do
        post 'create', {
            user: {
                email: 'charlie@unicron.com',
                password: 'password',
                password_confirmation: 'badness'
            }
        }
        results = JSON.parse(response.body)
        assert results['errors'], 'Errors were not present where they should have been'
    end

    test "#index without token in header" do
        get 'index'#, {}, {'Authorization' => "Bearer 12345"}
        assert response.status == 401
    end

    test '#index with invalid token' do
        get 'index', {}, {'Authorization' => "Bearer 12345"}
        assert response.status == 401
    end

    test '#index with expired token' do 
        joe = users(:joe)
        expired_api_key = joe.api_keys.session.create
        expired_api_key.update_attribute(:expired_at, 30.days.ago)
        assert !ApiKey.active.map(&:id).include?(expired_api_key.id)
        get 'index', {}, {'Authorization' => "Bearer #{expired_api_key.access_token}"}
        assert response.status == 401
    end

    test '#index with valid token' do
        joe = users(:joe)
        api_key = joe.session_api_key
        get 'index', {}, { 'Authorization' => "Bearer #{api_key.access_token}" }
        results = JSON.parse(response.body)
        assert results['users'].size == 2
    end
end
