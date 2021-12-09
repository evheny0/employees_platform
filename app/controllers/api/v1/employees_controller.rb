module Api
  module V1
    class EmployeesController < Api::V1::ApplicationController
      def index
        employees = EmployeesRepository.new.all.map do |employee|
          country = ApiClients::Restcountries.instance.by_code(employee.country)

          regional_id = nil
          if country.region == "Europe" || country.region == "Asia"
            regional_id = "#{employee.firstName}#{employee.lastName}#{employee.dateOfBirth}".downcase
          end

          employee.as_json.merge(
            conutryInfo: {
              fullName: country.common_name,
              currencies: country.currencies,
              languages: country.languages,
              timezones: country.timezones,
            },
            regionalId: regional_id
          )
        end

        render json: employees
      end
    end
  end
end
