class Nexudus::Import::Spaces::Coworker
  include Singleton

  attr_reader :client

  def initialize
    @client = Nexudus::Import::Spaces::CoworkerClient.new
  end

  # Updates users with data from the Nexudus API
  #
  # If we have some users in the database, only ask for coworkers updated since
  # the last updated user in the database.
  def update
    if User.count > 0
      timestamp = User
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
        user = User.find_or_initialize_by nexudus_id: coworker['UniqueId']

        user.first_name, user.last_name = coworker['FullName'].split(" ", 2)
        user.email                      = coworker['Email']
        user.nexudus_user_id            = coworker['UserID']
        user.nexudus_updated_at         = coworker['UpdatedOn']
        user.nexudus_created_at         = coworker['CreatedOn']
        #user.membership_level           = coworker['']
        #user.membership_renewal_date    = coworker['']
        #user.membership_status          = coworker['']
        user.active                     = coworker['Active']

        user.save!
        user
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
