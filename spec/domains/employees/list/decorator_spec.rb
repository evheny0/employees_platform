require "rails_helper"

RSpec.describe Employees::List::Decorator do
  describe "#call" do
    let(:employee) { EmployeesRepository::Employee.new(firstName: "firstName", lastName: "lastName", dateOfBirth: "11/11/1111") }
    let(:country) { ApiClients::Restcountries::CountryInfo.new(region: "Europe", currencies: %w(USD), timezones: %w(UTC), common_name: "Great Britain", languages: %w(EN)) }

    it "returns employee as_json" do
      expect(described_class.new(employee, country).as_json).to eq({
        "conutryInfo" => { "currencies" => %w(USD), "fullName" => "Great Britain", "languages" => %w(EN), "timezones" => %w(UTC) },
        "dateOfBirth" => "11/11/1111",
        "firstName" => "firstName",
        "lastName" => "lastName"
      })
    end
  end
end
