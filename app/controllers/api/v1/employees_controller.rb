module Api
  module V1
    class EmployeesController < Api::V1::ApplicationController
      def index
        employees = EmployeesRepository.new.all.map do |employee|
          country_info = HTTParty.get("https://restcountries.com/v3.1/alpha/#{employee.country}").first

          regional_id = nil
          if country_info["region"] == "Europe" || country_info["region"] == "Asia"
            regional_id = "#{employee.firstName}#{employee.lastName}#{employee.dateOfBirth}".downcase
          end

          employee.as_json.merge(
            conutryInfo: {
              fullName: country_info["name"]["common"],
              currencies: country_info["currencies"].keys,
              languages: country_info["languages"].keys,
              timezones: country_info["timezones"],
            },
            regionalId: regional_id
          )
        end

        render json: employees
      end
    end
  end
end
