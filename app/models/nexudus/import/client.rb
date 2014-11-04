class Nexudus::Import::Client
  include HTTParty

  base_uri "http://spaces.nexudus.com/api"
  default_params output: :json
  format :json
  default_timeout 30

  def initialize
    @params = {
      basic_auth: {
        username: Rails.application.secrets.nexudus_username,
        password: Rails.application.secrets.nexudus_password
      }
    }
  end

  def resources
    raise NotImplementedError
  end
end
