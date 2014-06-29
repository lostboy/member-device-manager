class Nexudus::Import::Spaces::Coworker
  include Singleton

  attr_reader :client

  def initialize
    @client = Nexudus::Import::Spaces::CoworkerClient.new
  end

  def update
    @client.coworkers['Records'].each.map do |coworker|
      user = User.find_or_initialize_by nexudus_id: coworker['UniqueId']

      user.first_name, user.last_name = coworker['FullName'].split(" ", 2)
      user.email                      = coworker['Email']
      user.nexudus_user_id            = coworker['UserID']
      user.nexudus_updated_at         = coworker['UpdatedOn']
      user.nexudus_created_at         = coworker['CreatedOn']
      #user.membership_level           = coworker['']
      #user.membership_status          = coworker['']
      user.active                     = coworker['Active']

      user.save!
      user
    end
  end
end
