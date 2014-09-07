class Nexudus::Import::Billing::Tariff < Nexudus::Import::Resource
  def initialize
    @client = Nexudus::Import::Billing::TariffClient.new
  end

  # Updates levels with data from the Nexudus API
  def update
    if Membership::Level.count > 0
      timestamp = Membership::Level
        .select(:nexudus_updated_at)
        .order(nexudus_updated_at: :desc)
        .first
        .nexudus_updated_at

      params = {
        'from_Tariff_UpdatedOn' => timestamp.iso8601
      }
    else
      params = nil
    end

    # Import with given params
    import params
  end

  private

  # Save given tariffs to the database
  def save tariff
    level = Membership::Level.find_or_initialize_by nexudus_id: tariff['Id']
    level.name                         = tariff['Name']
    level.price                        = tariff['Price']
    level.nexudus_updated_at           = tariff['UpdatedOn']
    level.nexudus_created_at           = tariff['CreatedOn']
    level.save!
  end
end
