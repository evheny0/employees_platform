module Employees
  module List
    class RegionalIdFactory
      REGION_MAPPING = {
        "Europe" => ->(employee) { "#{employee.firstName}#{employee.lastName}#{employee.dateOfBirth}".downcase },
        "Asia" => ->(employee) { "#{employee.firstName}#{employee.lastName}#{employee.dateOfBirth}".downcase }
      }.freeze

      def initialize(employee, country)
        @employee = employee
        @country = country
      end

      def call
        id_builder = REGION_MAPPING[@country.region]
        id_builder ? { regionalId: id_builder.call(@employee) } : {}
      end
    end
  end
end
