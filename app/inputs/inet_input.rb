class InetInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.tap do |options|
      options[:class] = [options[:class], "inet"].compact.join(' ')
      options[:data] ||= {}
      options[:data].merge! inet_options
    end
  end

  private
  def inet_options
    options = self.options.fetch(:inet_options, {})
    options = Hash[options.map{ |k, v| [k.to_s.camelcase(:lower), v] }]
    { inet_options: options }
  end
end
