class Nexudus::Import::Client
  include HTTParty

  base_uri "http://spaces.nexudus.com/api"
  default_params output: :json
  format :json
  default_timeout 30

  def initialize
    @params = {}
  end

  def resources
    raise NotImplementedError
  end
end
