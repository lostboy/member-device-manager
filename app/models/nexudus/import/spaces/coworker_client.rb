class Nexudus::Import::Spaces::CoworkerClient
  include HTTParty

  base_uri "http://spaces.nexudus.com/api"
  default_params output: :json
  format :json

  def initialize
    # TODO: Get the datetime of the last update, and only ask for coworkers
    # that has been updated/created since then.
    # ?from_Coworker_UpdatedOn=2012-10-08T23:13:38Z
    @params = { query: {} }
  end

  def coworkers
    self.class.get("/spaces/coworkers", @params)
  end
end
