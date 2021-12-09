module Employees
  module List
    class Decorator
      def initialize(employee, country)
        @employee = employee
        @country = country
      end

      def as_json
        result = @employee.as_json.merge(
          "conutryInfo" => {
            "fullName" => @country.common_name,
            "currencies" => @country.currencies,
            "languages" => @country.languages,
            "timezones" => @country.timezones,
          }
        )

        add_regional_id(result)
        result
      end

      private

      def add_regional_id(result)
        result.merge(Employees::List::RegionalIdFactory.new(@employee, @country).call)
      end
    end
  end
end
