require 'spec_helper.rb'

describe "Skybet Tests" do
  before :all do
    Appium::Driver.new(desired_capabilities).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup

    set_mock_gps_if_necessary
  end

  # before :each do
  #   $driver.start_driver
  # end

  after :all do
    $driver.driver_quit
  end

  context "Account" do
    # uncomment when test account comes.
    it "Logging in with valid credentials", valid: true do
      login
      binding.pry
      my_account
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
    # it "Place a bet on the favourite horse for the next race available", horse: true do
    #
    #   burger
    #   find('Horse Racing').click
    #   find_element(xpath: '//android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView[1]/android.webkit.WebView[1]/android.widget.GridView[1]/android.view.View[3]/android.view.View[1]/android.view.View[1]').click
    #   swipe start_x: 0, start_y: 0, end_x: 0, end_y: 50, duration: 500
    #   wait_true{find('No.')}
    #   #
    #   # find('No.').click
    #   # => find_elements('Price').click
    #   # binding.pry
    #
    #   find_element(xpath: '//android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.LinearLayout[1]/android.widget.FrameLayout[1]/android.webkit.WebView[1]/android.webkit.WebView[1]/android.view.View[5]/android.widget.ListView[1]/android.view.View[2]/android.widget.GridView[1]/android.view.View[2]/android.view.View[4]').click
    #
    #
    # end
  end

end
