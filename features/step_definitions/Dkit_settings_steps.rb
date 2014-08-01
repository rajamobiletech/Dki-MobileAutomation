Then(/^I open setting's from library page$/) do
  home.settings_page
end

Then(/^I open About from setting's page$/) do
 home.about_page
end

Then(/^I should be able to see the version page$/) do
home.about_page?
end

Then(/^I open the privacy page$/) do
home.privacy_page
sleep 10
end

# Then(/^I should be able to see the privacy web page$/) do
#   pending # express the regexp above with the code you wish you had
# end

Then(/^I open the legal page$/) do
home.legal_page
sleep 10
end

# Then(/^I should be able to see the legal web page$/) do
#   pending # express the regexp above with the code you wish you had
# end

Then(/^I close the About page from setting's$/) do
home.about_page_close
sleep 10
end

# Manage_devices
Then(/^I open Manage Devices$/) do
home.manage_devices
end

Then(/^I should be able to see the de\-register devices page$/) do
home.manage_devices_page?
end

Then(/^I select one device for de\-register$/) do
home.select_device
end

Then(/^I check the device has de\-registered$/) do
home.is_deregistered?
end

Then(/^I select close de\-register devices page$/) do
home.close
end

Then(/^I open preferences$/) do
home.dkit_settings
end

Then(/^I enable page preview from preferences$/) do
home.preview_on
end

# Then(/^I check page preview the preferences$/) do
#   pending # express the regexp above with the code you wish you had
# end

Then(/^I close the preference$/) do
home.close_preference
end

Then(/^I select derigester icon$/) do
 home.deregister_icon
end

Then(/^I check is deregistered$/) do
home.deregistered?
end

Then(/^I check the user name$/) do
home.user_name_display
end

When(/^Iam on Settings screen$/) do
   About_text = query("CordovaWebView css:'.about_icon'","textContent")
   Manage_Devicetext = query("CordovaWebView css:'.manage_icon'","textContent")
   Dreg_text = query("CordovaWebView css:'.deregister_icon'","textContent")
   Pref_text = query("CordovaWebView css:'.preference_icon'","textContent")
   usr_name = query("CordovaWebView css:'.user_icon'","textContent")
   FAbout_text = "Then I see"+" "+About_text.first+"\n"
   FManage_Devicetext = "Then I see"+" "+Manage_Devicetext.first+"\n"
   Fusr_name = "Then I see"+" "+usr_name.first+"\n"
   FDreg_text = "Then I see"+" "+Dreg_text.first+"\n"
   FPref_text = "Then I see"+" "+Pref_text.first+"\n"
    puts FAbout_text
    puts FManage_Devicetext
    puts FDreg_text
    puts FPref_text
    puts Fusr_name
end 