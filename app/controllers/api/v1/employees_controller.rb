module Api
  module V1
    class EmployeesController < Api::V1::ApplicationController
      EMPLOYEES = [
        {
          "firstName": "Roy",
          "lastName": "Testerton",
          "dateOfBirth": "19/02/1990",
          "jobTitle": "Software developer",
          "company": "Test co",
          "country": "US"
        },
        {
          "firstName": "Lisa",
          "lastName": "Testora",
          "dateOfBirth": "11/07/1984",
          "jobTitle": "CTO",
          "company": "Test co",
          "country": "GBR"
        },
        {
          "firstName": "Simon",
          "lastName": "McTester",
          "dateOfBirth": "01/11/1987",
          "jobTitle": "Product manager",
          "company": "Mock industries",
          "country": "IND"
        },
        {
          "firstName": "Selina",
          "lastName": "Testo",
          "dateOfBirth": "23/11/1972",
          "jobTitle": "Software developer",
          "company": "Mock industries",
          "country": "IND"
        },
        {
          "firstName": "Tim",
          "lastName": "Mockman",
          "dateOfBirth": "12/11/1972",
          "jobTitle": "Software developer",
          "company": "Mock industries",
          "country": "IND"
        },
        {
          "firstName": "Melissa",
          "lastName": "Mocker",
          "dateOfBirth": "10/01/1982",
          "jobTitle": "Software developer",
          "company": "Mock industries",
          "country": "US"
        }
      ].freeze

      def index
        employees = EMPLOYEES.map do |employee|
          country_info = HTTParty.get("https://restcountries.com/v3.1/alpha/#{employee[:country]}").first

          regional_id = nil
          if country_info["region"] == "Europe" || country_info["region"] == "Asia"
            regional_id = "#{employee[:firstName]}#{employee[:lastName]}#{employee[:dateOfBirth]}".downcase
          end

          employee.merge(
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
