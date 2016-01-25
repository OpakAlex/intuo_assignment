module ControllerHelpers
  extend ActiveSupport::Concern

  def json 
    JSON.parse(response.body) rescue {} 
  end

  def auth(user)
    token = TokenStore.generate(user)
    @request.env['HTTP_AUTHORIZATION'] = "Token token=#{token}"
  end
end
