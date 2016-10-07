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

  context "Logging in" do
    # uncomment when test account comes.
    # it "Logging in with valid credentials" do
    #   wait_true{find('Log in').displayed?}
    #   find('Log in').click
    #   find_elements(class: 'android.widget.EditText')[0].type 'User ID'
    #   find_elements(class: 'android.widget.EditText')[1].type 'PIN'
    #   button('Log in').click
    #   sleep 2
    #   wait_true{find('Go to My Account').displayed?}
    #   find('Go to My Account').click
    #   find('My Account')
    # end
    it "Attempt login with invalid details", invalid: true do

      wait_true{find('Log in').displayed?}
      find('Log in').click
      find_elements(class: 'android.widget.EditText')[0].type 'User ID'
      find_elements(class: 'android.widget.EditText')[1].type 'PIN'
      button('Log in').click
      sleep 2
      find('Sorry, there\'s been a problem logging into your account')

    end
  end

end
