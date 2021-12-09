require 'swagger_helper'

RSpec.describe 'api/v1/employees', type: :request do

  path '/api/v1/employees' do

    get 'list employees' do
      response 200, 'Returns an array of employees' do
        schema type: :array, items: {
          type: :object,
          properties: {
            firstName: { type: :string },
            lastName: { type: :string },
            dateOfBirth: { type: :string },
            jobTitle: { type: :string },
            company: { type: :string },
            country: { type: :string },
            regionalId: { type: :string },
            conutryInfo: {
              type: :object,
              properties: {
                fullName: { type: :string },
                currencies: { type: :array, items: { type: :string } },
                languages: { type: :array, items: { type: :string } },
                timezones: { type: :array, items: { type: :string } },
              },
              required: [:fullName, :currencies, :languages, :timezones]
            }
          },
          required: [:firstName, :lastName, :dateOfBirth, :jobTitle, :company, :country, :conutryInfo]
        }

        examples 'application/json' => [
          {
            "firstName": "Lisa",
            "lastName": "Testora",
            "dateOfBirth": "11/07/1984",
            "jobTitle": "CTO",
            "company": "Test co",
            "country": "GBR",
            "conutryInfo": {
              "fullName": "United Kingdom",
              "currencies": [
                "GBP"
              ],
              "languages": [
                "eng"
              ],
              "timezones": [
                "UTC-08:00",
                "UTC-05:00",
                "UTC-04:00",
                "UTC-03:00",
                "UTC-02:00",
                "UTC",
                "UTC+01:00",
                "UTC+02:00",
                "UTC+06:00"
              ]
            }
          },
        ]
        run_test!
      end
    end
  end
end
