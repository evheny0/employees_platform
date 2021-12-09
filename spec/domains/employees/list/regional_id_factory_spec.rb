require "rails_helper"

RSpec.describe Employees::List::RegionalIdFactory do
  describe "#call" do
    let(:employee) { instance_double(EmployeesRepository::Employee, firstName: "firstName", lastName: "lastName", dateOfBirth: "11/11/1111") }
    let(:country) { instance_double(ApiClients::Restcountries::CountryInfo, region: "Europe") }

    it "generates special id for Europe" do
      expect(described_class.new(employee, country).call).to eq("firstnamelastname11/11/1111")
    end
  end
end
