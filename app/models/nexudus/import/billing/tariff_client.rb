class Nexudus::Import::Billing::TariffClient
  include HTTParty

  base_uri "http://spaces.nexudus.com/api"
  default_params output: :json
  format :json

  def initialize
    @params = {}
  end

  def tariffs(options={})
    options.merge! @params
    self.class.get("/billing/tariffs", options)
  end
end
