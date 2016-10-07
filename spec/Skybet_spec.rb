require 'spec_helper.rb'

describe "Skybet Tests" do
  before :all do
    Appium::Driver.new(desired_capabilities).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup

    set_mock_gps_if_necessary
  end

  before :each do
    $driver.start_driver
  end

  after :all do
    $driver.driver_quit
  end

  context "Launch using mock GPS location" do
    it "Logging in with valid credentials" do
      #binding.pry
    end
  end

  context "find specific markets" do
    it "locates a specific football match" do
      findFootballMatch('17:00')
      expect(find('Euro U21 Qualifier')).not_to eq nil
    end
  end

  context "Bet on specific markets", market:true do
    it "allows for a out right football bet to be placed" do
      findFootballMatch('17:00')
      #binding.pry
      find("Win").click
      expect(find('U21')).not_to eq nil
      expect(find('Total Stake')).not_to eq nil
    end
  end

end
