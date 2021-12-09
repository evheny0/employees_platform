require "rails_helper"

RSpec.describe ApiClients::Restcountries do
  let(:responce_it) { [{"name" => {"common" => "Italy","official" => "Italian Republic","nativeName" => {"ita" => {"official" => "Repubblica italiana","common" => "Italia"}}},"tld" => [".it"],"cca2" => "IT","ccn3" => "380","cca3" => "ITA","cioc" => "ITA","independent" => true,"status" => "officially-assigned","unMember" => true,"currencies" => {"EUR" => {"name" => "Euro","symbol" => "€"}},"idd" => {"root" => "+3","suffixes" => ["9"]},"capital" => ["Rome"],"altSpellings" => ["IT","Italian Republic","Repubblica italiana"],"region" => "Europe","subregion" => "Southern Europe","languages" => {"ita" => "Italian"},"translations" => {},"latlng" => [42.83333333,12.83333333],"landlocked" => false,"borders" => ["AUT","FRA","SMR","SVN","CHE","VAT"],"area" => 301336.0,"demonyms" => {"eng" => {"f" => "Italian","m" => "Italian"},"fra" => {"f" => "Italienne","m" => "Italien"}},"flag" => "","maps" => {"googleMaps" => "https://goo.gl/maps/8M1K27TDj7StTRTq8","openStreetMaps" => "https://www.openstreetmap.org/relation/365331"},"population" => 59554023,"gini" => {"2017" => 35.9},"fifa" => "ITA","car" => {"signs" => ["I"],"side" => "right"},"timezones" => ["UTC+01:00"],"continents" => ["Europe"],"flags" => {"png" => "https://flagcdn.com/w320/it.png","svg" => "https://flagcdn.com/it.svg"},"coatOfArms" => {"png" => "https://mainfacts.com/media/images/coats_of_arms/it.png","svg" => "https://mainfacts.com/media/images/coats_of_arms/it.svg"},"startOfWeek" => "monday","capitalInfo" => {"latlng" => [41.9,12.48]},"postalCode" => {"format" => "#####","regex" => "^(\\d{5})$"}}] }

  describe "#by_code" do
    let(:return_value) { ApiClients::Restcountries::CountryInfo.new(region: "Europe", common_name: "Italy", currencies: ["EUR"], languages:["ita"], timezones: ["UTC+01:00"]) }

    it "make request to restcountries" do
      expect(HTTParty).to receive(:get).with("https://restcountries.com/v3.1/alpha/IT").and_return(responce_it)
      expect(described_class.new.by_code("IT")).to eq(return_value)
    end
  end

  describe "##instance" do
    let(:return_value) { ApiClients::Restcountries::CountryInfo.new(region: "Europe", common_name: "Italy", currencies: ["EUR"], languages:["ita"], timezones: ["UTC+01:00"]) }

    it "make request to restcountries only once for certain country" do
      expect(HTTParty).to receive(:get).with("https://restcountries.com/v3.1/alpha/IT").and_return(responce_it)
      described_class.instance.by_code("IT")

      expect(HTTParty).not_to receive(:get)
      expect(described_class.instance.by_code("IT")).to eq(return_value)
    end

    it "make request to restcountries for other country" do
      expect(HTTParty).to receive(:get).with("https://restcountries.com/v3.1/alpha/SP").and_return(responce_it)
      described_class.instance.by_code("SP")

      expect(HTTParty).to receive(:get).with("https://restcountries.com/v3.1/alpha/other_country").and_return(responce_it)
      described_class.instance.by_code("other_country")
    end
  end
end
