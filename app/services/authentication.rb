class Authentication
  delegate :authorized?, to: :authorization

  attr_reader :authorization

  def initialize(params)
    @authorization = StravaLib::AuthorizationResponse.new(params)
  end

  def authenticate
    if authorized?
      response = StravaLib::TokenRequest.new(authorization.code)
      return response.athlete
    else
      false
    end
  end
end
