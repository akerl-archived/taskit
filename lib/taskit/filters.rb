module Taskit
  ##
  # Define filters for selecting issues
  module Filters
    def select(&block)
      Taskit::Tasks.new(
        client: @client,
        issues: @issues.select(&block)
      )
    end

    def by_label(input)
      select { |issue| issue.labels.any? { |label| label.name.match input } }
    end

    def respond_to_missing?(method, include_private = false)
      var = parse_var method
      return true if var && @issues.first.respond_to?(var)
      super
    end

    private

    def parse_var(string)
      match = /^by_(?<var>[a-z]+)$/.match(string)
      match ? match[:var] : nil
    end

    def method_missing(method, *args, &block)
      var = parse_var method
      return super unless var && @issues.first.respond_to?(var)
      define_singleton_method(method) { |x| select { |i| i.send(var).match x } }
      send(method, *args, &block)
    end
  end
end
