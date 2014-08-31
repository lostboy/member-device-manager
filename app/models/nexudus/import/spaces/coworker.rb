class Nexudus::Import::Spaces::Coworker
  include Singleton

  attr_reader :client

  def initialize
    @client = Nexudus::Import::Spaces::CoworkerClient.new
  end

  # Updates members with data from the Nexudus API
  #
  # If we have some members in the database, only ask for coworkers updated since
  # the last updated members in the database.
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

    # The api is paginated, so we need to loop through all pages
    complete = false
    until complete
      response = @client.coworkers(params)
      response['Records'].each.map do |coworker|
        member = Member.find_or_initialize_by nexudus_id: coworker['UniqueId']

        member.first_name, member.last_name = coworker['FullName'].split(" ", 2)
        member.email                      = coworker['Email']
        member.nexudus_user_id            = coworker['UserID']
        member.nexudus_updated_at         = coworker['UpdatedOn']
        member.nexudus_created_at         = coworker['CreatedOn']
        #member.membership_level           = coworker['']
        #member.membership_renewal_date    = coworker['']
        #member.membership_status          = coworker['']
        member.active                     = coworker['Active']

        member.save!
        member
      end

      currentPage = response['CurrentPage']
      totalPages = response['TotalPages']

      if currentPage == totalPages
        complete = true
      else
        nextPage = currentPage += 1
        { 'page' => nextPage }.merge! params || {}
      end
    end
  end
end
