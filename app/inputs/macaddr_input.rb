class MacaddrInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.tap do |options|
      options[:class] = [options[:class], "macaddr"].compact.join(' ')
      options[:data] ||= {}
      options[:data].merge! macaddr_options
    end
  end

  private
  def macaddr_options
    options = self.options.fetch(:macaddr_options, {})
    options = Hash[options.map{ |k, v| [k.to_s.camelcase(:lower), v] }]
    { macaddr_options: options }
  end
end
