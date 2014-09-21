class Nexudus::Import::Resource
  include Singleton

  attr_reader :client

  private

  def import params
    # The api is paginated, so we need to loop through all pages
    loop do
      # Fetch resources
      response = @client.resources(params)

      # Import resources
      response['Records'].each do |record|
        save record
      end

      currentPage = response['CurrentPage']
      totalPages = response['TotalPages']

      # Update page attribute in params to ask for next page
      { page: currentPage + 1 }.merge! params || {}

      # If we are on last page, break out of loop
      break if currentPage >= totalPages
    end
  end

  # Save given resources to the database
  def save
    raise NotImplementedError
  end
end
