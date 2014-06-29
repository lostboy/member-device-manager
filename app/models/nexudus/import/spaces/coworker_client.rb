class Nexudus::Import::Spaces::CoworkerClient
  include HTTParty

  base_uri "http://spaces.nexudus.com/api"
  default_params output: :json
  format :json

  def initialize
    @params = {}
  end

  def coworkers(options={})
    options.merge! @params
    self.class.get("/spaces/coworkers", options)
  end
end
