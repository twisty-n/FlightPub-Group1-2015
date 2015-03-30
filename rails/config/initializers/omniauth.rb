OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '247383629958-il1m2l9l9cjgmspv24ojtm6i0o2boubb.apps.googleusercontent.com', 'SFAiAIB9SVkmIJNAqYsbeySW', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end