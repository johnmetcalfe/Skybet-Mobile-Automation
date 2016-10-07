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
      binding.pry
    end
  end
end
