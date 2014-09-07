class Nexudus::Import::Spaces::CoworkerClient < Nexudus::Import::Client
  def resources(options={})
    options.merge! @params
    self.class.get("/spaces/coworkers", options)
  end
end
