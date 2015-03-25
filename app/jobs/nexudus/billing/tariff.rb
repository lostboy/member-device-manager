module Nexudus::Billing
  class Tariff
    include Sidekiq::Worker

    sidekiq_options queue: :nexudus, retry: true

    def perform
      Nexudus::Billing::Tariff.instance.update
    end
  end
end
