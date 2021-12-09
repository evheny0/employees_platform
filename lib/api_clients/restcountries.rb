module ApiClients
  class Restcountries
    BY_CODE_URL = "https://restcountries.com/v3.1/alpha/"

    class CountryInfo
      include ShallowAttributes

      attribute :region, String
      attribute :common_name, String
      attribute :currencies, String
      attribute :languages, String
      attribute :timezones, String
    end

    def self.instance
      @instance ||= new
    end

    def initialize
      @countries = {}
    end

    def by_code(country_code)
      @countries[country_code] ||= begin
        country_info = HTTParty.get(BY_CODE_URL + country_code).first

        CountryInfo.new(
          region: country_info["region"],
          common_name: country_info["name"]["common"],
          currencies: country_info["currencies"].keys,
          languages: country_info["languages"].keys,
          timezones: country_info["timezones"],
        )
      end
    end
  end
end
