Then /^I press back button$/ do
  class Automation
    extend Calabash::Android::Operations
    def self.press_back_button
      cmd = "#{default_device.adb_command} shell input keyevent 4"
      system(cmd)
    end
  end
  Automation.press_back_button
  sleep 20
end