require 'rspec'
require 'pry'
require 'appium_lib'
require 'support'

RSpec.configure do|config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

def desired_capabilities
  {
    caps: {
      platformName: "Android",
      deviceName: "emulator-5554",
      app: "./binaries/Tumblr.apk",
      newCommandTimeout:600
    },
    appium_lib: {
      :sauce_username => nil,
      :sauce_access_key => nil
    }
  }
end

def hide_keyboard
  # hides the keyboard if it exists
  begin
    $driver.hide_keyboard
  rescue

  end
end

def enter_text(textfield, text)
  hide_keyboard
  textfield.type text
end

def scroll_click(identifier)
  begin
    swipe start_x: 0, start_y: 0, end_x: 0, end_y: 200, duration: 500
    find('Allow mock locations').click
  rescue
    scroll_click identifier
  end
end

def set_mock_gps_if_necessary
  begin
    return unless gps_fix_needed?

    `adb install binaries/fake_gps.apk` unless app_installed? 'com.lexa.fakegps'
    `adb shell monkey -p com.lexa.fakegps -c android.intent.category.LAUNCHER 1`

    begin
      wait_true(2) {find('OPEN SETTINGS').displayed?}
      find('OPEN SETTINGS').click
      wait_true(2) {find('Developer options').displayed?}
      scroll_click 'Allow mock locations'
      back
    rescue
    ensure
      begin
        find('Search').click
      rescue
      ensure
        puts "ensure"
        first_textfield.type "Leeds UK\n"
        hide_keyboard
        find_elements(class: 'android.widget.ImageButton').last.click
      end
    end
  rescue
  end
end

def gps_fix_needed?
  begin
    return true if wait_true(1) {text('location').displayed? || text('Loading...').displayed?}
  rescue
    begin
      return false if wait_true(1) {find('Accumulators').displayed?}
    rescue
      setup_fake_gps_location
    end
  end
end
