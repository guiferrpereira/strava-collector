module StravaLib
  class AuthorizationResponse

    attr_reader :code, :error

    def initialize(params)
      @code   = params[:code]
      @error  = params[:error]
    end

    def authorized?
      code.present?
    end

  end

  class AuthorizationRequest

    def self.url
      new.url
    end

    def url
      "#{uri}?#{params.to_query}"
    end

    private

    def uri
      StravaCollector.config.strava[:authorize_uri]
    end

    def params
      {
        client_id:        StravaCollector.config.strava[:client_id],
        redirect_uri:     StravaCollector.config.strava[:authorize_redirect_uri],
        response_type:    :code,
        scope:            :write,
        approval_prompt:  :auto
      }
    end

  end

  class TokenRequest

    attr_reader :authorization_code

    def initialize(authorization_code)
      @authorization_code = authorization_code
    end

    def athlete
      TokenResponse.new(response_body).athlete
    end

    private

    def response_body
      HTTParty.post(uri, query: params).body
    end

    def uri
      StravaCollector.config.strava[:token_uri]
    end

    def params
      {
        client_id:      StravaCollector.config.strava[:client_id],
        client_secret:  StravaCollector.config.strava[:client_secret],
        code:           authorization_code
      }
    end

  end

  class TokenResponse

    attr_reader :response_json, :athlete

    def initialize(response_json)
      @response_json = response_json
    end

    def athlete
      @athlete ||= Athlete.find_or_create(@response_json)
    end
  end
end
