class Nexudus::Import::Billing::Tariff
  include Singleton

  attr_reader :client

  def initialize
    @client = Nexudus::Import::Billing::TariffClient.new
  end

  # Updates levels with data from the Nexudus API
  def update
    if last_updated_at
      params = {
        'from_Tariff_UpdatedOn' => last_updated_at.iso8601
      }
    else
      params = nil
    end

    # The api is paginated, so we need to loop through all pages
    loop do
      # Fetch tariffs
      response = @client.tariffs(params)

      # Import tariffs
      import response['Records']

      currentPage = response['CurrentPage']
      totalPages = response['TotalPages']

      # Update page attribute in params to ask for next page
      { page: currentPage + 1 }.merge! params || {}

      # If we are on last page, break out of loop
      break if currentPage >= totalPages
    end
  end

  private

  # Retrive timestamp for last updated level
  def last_updated_at
    if Membership::Level.count > 0
      Membership::Level
        .select(:nexudus_updated_at)
        .order(nexudus_updated_at: :desc)
        .first
        .nexudus_updated_at
    else
      nil
    end
  end

  # Save given tariffs to the database
  def import tariffs
    tariffs.each do |tariff|
      level = Membership::Level.find_or_initialize_by nexudus_id: tariff['Id']
      level.name                         = tariff['Name']
      level.price                        = tariff['Price']
      level.nexudus_updated_at           = tariff['UpdatedOn']
      level.nexudus_created_at           = tariff['CreatedOn']
      level.save!
    end
  end
end
