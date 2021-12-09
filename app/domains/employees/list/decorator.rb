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
        regional_id = Employees::List::RegionalIdFactory.new(@employee, @country).call
        result.merge(regionalId: regional_id) if regional_id
        result
      end
    end
  end
end
