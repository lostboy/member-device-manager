require './config/boot'
require './config/environment'

require './app/jobs/nexudus/spaces/coworkers/import'

include Clockwork

every 1.minute, 'Update coworker data from Nexudus' do
  Nexudus::Jobs::Spaces::Coworker.perform_async
end
