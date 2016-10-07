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
      wait_true{find('login')}
      wait_true{find_element(xpath:'//android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView[1]/android.webkit.WebView[1]/android.view.View[1]/android.view.View[1]/android.view.View[1]')}.click
      wait_true{find('Football')}.click
      find('17:00').click
      expect(find('Euro U21 Qualifier')).not_to eq nil
    end

  end
end
