class Nexudus::Import::Spaces::Coworker < Nexudus::Import::Resource
  def initialize
    @client = Nexudus::Import::Spaces::CoworkerClient.new
  end

  # Updates members with data from the Nexudus API
  def update
    if Member.count > 0
      timestamp = Member
        .select(:nexudus_updated_at)
        .order(nexudus_updated_at: :desc)
        .first
        .nexudus_updated_at

      params = {
        'from_Coworker_UpdatedOn' => timestamp.iso8601
      }
    else
      params = nil
    end

    # Import with given params
    import params
  end

  private

  # Save given coworker to the database
  def save coworker
    member = Member.find_or_initialize_by nexudus_unique_id: coworker['UniqueId']
    member.first_name, member.last_name = coworker['FullName'].split(" ", 2)
    member.email                        = coworker['Email']
    member.nexudus_id                   = coworker['Id']
    member.nexudus_user_id              = coworker['UserID']
    member.nexudus_updated_at           = coworker['UpdatedOn']
    member.nexudus_created_at           = coworker['CreatedOn']
    #member.membership_level             = coworker['']
    #member.membership_renewal_date      = coworker['']
    #member.membership_status            = coworker['']
    member.active                       = coworker['Active']
    member.save!
  end
end
