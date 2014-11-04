class Nexudus::Import::Spaces::CoworkerClient < Nexudus::Import::Client
  def resources(options={})
    options = options ? options.merge!(@params) : @params
    self.class.get("/spaces/coworkers", options)
  end
end
