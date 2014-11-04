class Nexudus::Import::Billing::TariffClient < Nexudus::Import::Client
  def resources(options={})
    options = options ? options.merge!(@params) : @params
    self.class.get("/billing/tariffs", options)
  end
end
