require 'calabash-android/calabash_steps'

When /^student login with "(.*?)" and "(.*?)"$/ do |user,password|
  @user = User.new(user,password)
  home.login(@user)
end


Given(/^Valid User want to login to the Application$/) do
  @user = User.get_user("default")
end

When(/^user login with valid credentials$/) do
  home.login(@user)
end


Then(/^user should see the library page$/) do
sleep(5)
  assert(home.book_list?, "true")
end

Given /^student logged in to dkit reader application$/ do
   sleep(10)
  @user = User.get_user(ENV['DKIT_USER'] || "default")
  if ENV['DEVICE_ENDPOINT'] || ENV["NO_LAUNCH"] == "1"
    handle_application_reset
  else
    sleep(5)
    handle_application_reset
  end
  sleep(2)
end
def handle_application_reset
  if home.login_page?
    home.login(@user)
	sleep(5)
  elsif home.book_list?
    return
  end
end
When /^user on login page$/ do
# @calabash.element_exists("CordovaWebView css:'#loginBtn'")
  sleep(30)
   Choose_Lang = query("CordovaWebView css:'#chooseLangLabel'",'textContent')
   Select_Lang = query("CordovaWebView css:'#selectLang'",'textContent')
   User_Ltext = query("CordovaWebView css:'#userNameLabel'","textContent")
   Uedit_text = query("CordovaWebView css:'#user_name'",'value')
   Pwd_Ltext = query("CordovaWebView css:'#passwordLabel'","textContent")
   Pedit_text = query("CordovaWebView css:'#password'",'value')
   Button_text = query("CordovaWebView css:'#loginBtn'","textContent")
   FChoose_Lang = "Then I see"+" "+ Choose_Lang.first+Select_Lang.first+"\n"
    puts FChoose_Lang
   Fuser_name = "Then I see"+" "+User_Ltext.first+":"+Uedit_text.first+"\n"
    puts Fuser_name
   Fuser_pwd = "Then I see"+" "+Pwd_Ltext.first+":"+Pedit_text.first+"\n"
     puts Fuser_pwd
   Fuser_Login = "Then I see"+" "+ Button_text.first+" "+"button"+"\n"
     puts Fuser_Login
 
 end