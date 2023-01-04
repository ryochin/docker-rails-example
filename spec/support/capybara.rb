require 'selenium-webdriver'
require 'capybara/rspec'

Capybara.configure do |config|
  config.default_driver         = :rack_test
  config.javascript_driver      = :remote_chrome
  config.run_server             = true
  config.default_selector       = :css
  config.default_max_wait_time  = 5
  config.ignore_hidden_elements = true
  config.save_path              = Dir.pwd
  config.automatic_label_click  = true
  config.server                 = :puma, { Silent: true }
end

Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument 'disable-notifications'
  options.add_argument 'disable-translate'
  options.add_argument 'disable-extensions'
  options.add_argument 'disable-infobars'
  options.add_argument 'window-size=1280,960'

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url:     ENV.fetch('SELENIUM_DRIVER_URL') { 'http://browser:4444/wd/hub' },
    options: options
  )
end

RSpec.configure do |config|
  config.before(:each, type: :feature, js: true) do
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host    = URI::HTTP.build(host: Capybara.server_host, port: Capybara.server_port).to_s
  end
end
