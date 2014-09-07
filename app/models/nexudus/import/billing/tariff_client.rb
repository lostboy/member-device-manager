class Nexudus::Import::Billing::TariffClient < Nexudus::Import::Client
  def resources(options={})
    options.merge! @params
    self.class.get("/billing/tariffs", options)
  end
end
