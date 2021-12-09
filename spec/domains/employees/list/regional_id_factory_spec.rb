require "rails_helper"

RSpec.describe Employees::List::RegionalIdFactory do
  describe "#call" do
    let(:employee) { instance_double(EmployeesRepository::Employee, firstName: "firstName", lastName: "lastName", dateOfBirth: "11/11/1111") }

    context "Europe" do
      let(:country) { instance_double(ApiClients::Restcountries::CountryInfo, region: "Europe") }

      it "generates special id" do
        expect(described_class.new(employee, country).call).to eq(regionalId: "firstnamelastname11/11/1111")
      end
    end

    context "Asia" do
      let(:country) { instance_double(ApiClients::Restcountries::CountryInfo, region: "Asia") }

      it "generates special id" do
        expect(described_class.new(employee, country).call).to eq(regionalId: "firstnamelastname11/11/1111")
      end
    end

    context "Africa" do
      let(:country) { instance_double(ApiClients::Restcountries::CountryInfo, region: "Africa") }

      it "returns nil" do
        expect(described_class.new(employee, country).call).to eq({})
      end
    end
  end
end
