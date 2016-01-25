module AuthMixin

  extend ActiveSupport::Concern

  included do
    attr_accessor :token
    attr_accessor :current_user
  end

  def authenticate
    authenticate_or_request_with_http_token do |token|
      self.token = token
      self.current_user = TokenStore.current_user(token)
    end
  end

  def generate_auth_data(user)
    token = generate_token(user)
    data = {
      token: token,
      email: user.email
    }
  end

  def generate_token(user)
    TokenStore.generate(user)
  end

  def invalidate_current_token
    TokenStore.invalidate(token)
  end
  
end
