class Authentication
  delegate :authorized?, to: :authorization
  delegate :access_token, :athlete, to: :token_response

  attr_reader :authorization

  def initialize(params)
    @authorization = StravaLib::AuthorizationResponse.new(params)
  end

  def authenticate
    if authorized?
      access_token
      # user.update_attributes(access_token: access_token)
      # user
    else
      false
    end
  end

  # def user
  #   @user ||= User.find_or_create_by(uid: athlete.id) do |user|
  #     user.uid        = athlete.id
  #     user.first_name = athlete.firstname
  #     user.last_name  = athlete.lastname
  #   end
  # end

  private

  def token_response
    binding.pry
    @token_response ||= StravaLib::TokenRequest.new(authorization.code).response
  end
end
