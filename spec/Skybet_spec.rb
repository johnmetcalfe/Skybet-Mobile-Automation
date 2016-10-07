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

  context "Account" do
    # uncomment when test account comes.
    it "Logging in with valid credentials", valid: true do
      login
      goto_my_account
    end

    it "Attempt login with invalid details", invalid: true do

      wait_true{find('Log in').displayed?}
      find('Log in').click
      find_elements(class: 'android.widget.EditText')[0].type 'User ID'
      find_elements(class: 'android.widget.EditText')[1].type 'PIN'
      button('Log in').click
      sleep 2
      find('Sorry, there\'s been a problem logging into your account')

    end

    it "Check most recent bet has won", winning: true do

      login
      my_account
      find('Settled bets').click
      find('You won')

    end
  end

  context "Placing Bets" do
    # Can't Hook onto the odds for each horse.
    it "Place a bet on the favourite horse for the next race available", horse: true do

      burger
      find('Horse Racing').click
      find_element(xpath: '//android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView[1]/android.webkit.WebView[1]/android.widget.GridView[1]/android.view.View[5]/android.view.View[1]/android.view.View[1]').click
      click_first_horse
      binding.pry
    end
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
    it "allows for another football market to be added to the betslip", correctScore:true do
      findFootballMatch('17:00')
      find("Correct Score").click
      find("2-0").click
      expect(find('U21')).not_to eq nil
      expect(find('Total Stake')).not_to eq nil
      expect(find('Czech Republic U21 2-0')).to_not eq nil
    end
  end
end
