module Nexudus::Spaces
  class Coworker
    include Sidekiq::Worker

    sidekiq_options queue: :nexudus, retry: true

    def perform
      Nexudus::Spaces::Coworker.instance.update
    end
  end
end
