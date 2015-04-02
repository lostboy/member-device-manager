require './config/boot'
require './config/environment'

require './app/jobs/nexudus/spaces/coworker'

include Clockwork

every 1.minute, 'Update coworker data from Nexudus' do
  Nexudus::Spaces::Coworker.perform_async
end
