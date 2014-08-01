class HomePage < BasePage
  def login(user)
    #@calabash.wait_for_elements_exist( ["CordovaWebView css:'#loginBtn'"])
    sleep(15)
    keyboard_enter_text('input[id=user_name]', user.username)
    sleep(STEP_PAUSE)
    keyboard_enter_text('input[id=password]', user.password)
    sleep(1)
    @calabash.touch("CordovaWebView css:'#loginBtn'")
    3.times do
      sleep(STEP_PAUSE)
      @calabash.touch("CordovaWebView css:'#loginBtn'") if @calabash.query("CordovaWebView css:'#loginBtn'").count > 0
    end
    sleep(3) # wait more time to get the book list get updated
  end

  def login_page?
    if @calabash.element_does_not_exist("CordovaWebView css:'#loginBtn'")
      @calabash.wait_for_elements_do_not_exist(["CordovaWebView css:'#loginBtn'"])
      end
      @calabash.query("CordovaWebView css:'#loginBtn'").count > 0
  end

  def book_list?
    @calabash.query("CordovaWebView css:'ul#courses_list'").count > 0
  end

  def open_book(title)
    sleep(2) unless @calabash.query("CordovaWebView css:'ul#courses_list'").count > 0 # Wait more time if the book list is not appeared
    book_index=downloaded_book_index(title)
    @calabash.screenshot_and_raise "Unable to find downloaded book with title - #{title} " unless book_index >= 0
    @calabash.touch(@calabash.query("CordovaWebView css:'ul#courses_list>li:not(.downloadable)' ")[book_index])
    sleep(STEP_PAUSE)
  end

  def downloadable_books
    @calabash.query("CordovaWebView css:'li.downloadable h2'")
  end

  def ready_for_download?(title)
    downloadable_books.each_with_index do |book|
      return true if book["textContent"].strip == title
    end
    return false
  end
  def download_book(title,wait_finish=true)
    book_index=-1
    downloadable_books.each_with_index do |book,index|
      if book["textContent"].strip == title
       @calabash.touch(@calabash.query("CordovaWebView css:'li.downloadable a.download-course'")[index])
        book_index=index
        break
      end
    end
    @calabash.screenshot_and_raise "Unable to find downloadable book with title - #{title} " unless book_index >= 0
    if wait_finish
      sleep(STEP_PAUSE)
      while @calabash.query("CordovaWebView css:'li.downloadable div.progress-bar'").count > 0
        #@calabash.performAction('wait_for_no_progress_bars')
        #sleep(STEP_PAUSE+STEP_PAUSE)
        sleep(STEP_PAUSE) # TODO: need to add timeout
      end
    end
    sleep(STEP_PAUSE)
  end

  def pause_download(title)
    @calabash.wait_for_elements_exist( ["CordovaWebView css:'.downloading'"])
   @calabash.touch ("CordovaWebView css:'li.downloadable a.pause-button'")
  end

  def resume_download(title)
    @calabash.touch ("CordovaWebView css:'li.downloadable a.play-button'")
  end

  def cancel_download
   @calabash.touch ("CordovaWebView css:'li.downloadable a.cancel-button'")
  end

  def download_paused?
    sleep(STEP_PAUSE)
     @calabash.query("CordovaWebView css:'span#status-text'").each do |ele|
     return true if ele["textContent"].strip == "paused"
     end
   false
  end

  def download_resume?
    sleep(STEP_PAUSE)
    @calabash.query("CordovaWebView css:'span#status-text'").each do |ele|
      return true if ele["textContent"].strip == "downloading"
    end
    false
  end

  def download_canceled?
    sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'li.downloadable div.progress-bar'")
        @calabash.screenshot_and_raise "Unsuccessful canceling"
      else
        puts "Successfully canceled"
      end
  end

  def  downloaded?(title)
    downloaded_book_index(title) >= 0 ? true : false
  end

  def long_tap(title)
    book_index=downloaded_book_index(title)
    @calabash.screenshot_and_raise "Unable to find downloaded book with title - #{title} " unless book_index >= 0
    @calabash.long_press(@calabash.query("CordovaWebView css:'li.downloaded'")[book_index])
   # @calabash.playback "text_selection",{:query => "webView css:'ul#courses_list>li:not(.downloadable)' index:#{book_index}"}
  end

  def press_remove(title)
    book_index=downloaded_book_index(title)
    @calabash.screenshot_and_raise "Unable to find downloaded book with title - #{title} " unless book_index >= 0
      @calabash.touch(@calabash.query("CordovaWebView css:'span.delete-book'")[book_index])
    sleep(STEP_PAUSE + STEP_PAUSE)
    @calabash.performAction('click_on_text','Yes')
    sleep(2)
    sleep(STEP_PAUSE + STEP_PAUSE) if ENV['DEVICE_ENDPOINT']
  end

  def downloaded_book_index(title)
    downloaded_books = @calabash.query("CordovaWebView css:'ul.group li.downloaded a  h2'")
    book_index=-1
    downloaded_books.each_with_index do |book,index|
      if book["textContent"].strip == title
        book_index=index
        break
      end
    end
    book_index
  end

def download_book_progress
  @calabash.performAction('wait_for_no_progress_bars')
  sleep(STEP_PAUSE+STEP_PAUSE)
end

def deregister
  sleep(STEP_PAUSE)
  @calabash.touch("CordovaWebView css:'.settings_icon'")
  @calabash.touch("CordovaWebView css:'.deregister_icon'")
  sleep(STEP_PAUSE)
  @calabash.performAction('click_on_text','Yes')
end
########################################################################################################################
  #Dikt Library setting's Page methods
def settings_page
    sleep(STEP_PAUSE)
    if @calabash.element_exists("CordovaWebView css:'.settings_icon'")
       @calabash.touch("CordovaWebView css:'.settings_icon'")
    else
      @calabash.screenshot_and_raise "Unable to find setting's in Library Page"
    end
end

def about_page
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'.about_icon'")
    @calabash.touch("CordovaWebView css:'.about_icon'")
   else
    @calabash.screenshot_and_raise "Unable to find About icon in setting's from Library Page"
  end
end

def about_page?
  sleep(STEP_PAUSE)
   if @calabash.element_exists("CordovaWebView css:'h1[class=\"cisco_text_logo\"]'")
     puts "About setting's page is available"
   else
     @calabash.screenshot_and_raise "Failed to open about page"
   end
end

def privacy_page
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'a[id=\"privacy_policy\"]'")
    @calabash.touch("CordovaWebView css:'a[id=\"privacy_policy\"]'")
  else
    @calabash.screenshot_and_raise "Unable to find Privacy Policy page in setting's from Library Page"
  end
end

def legal_page
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'a[id=\"legal\"]'")
    @calabash.touch("CordovaWebView css:'a[id=\"legal\"]'")
  else
    @calabash.screenshot_and_raise "Unable to find legal page in setting's from Library Page"
  end
end

def about_page_close
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'input[class=\"close-btn\"]'")
    @calabash.touch("CordovaWebView css:'input[class=\"close-btn\"]'")
  else
    @calabash.screenshot_and_raise "Unable to Close the about setting's page"
  end
end

def manage_devices
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'.manage_icon'")
    @calabash.touch("CordovaWebView css:'.manage_icon'")
  else
    @calabash.screenshot_and_raise "Unable to find Manage Devices in setting's page"
  end
end

def manage_devices_page?
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'ul[class=\"deregister\"]'")
    puts "Manage devices Page is displaying"
  else
    @calabash.screenshot_and_raise "Unable to find Manage Devices in setting's page"
  end
end
def select_device
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'button[class=\"deregister-btn hidden\"]'")
  ele = @calabash.query("CordovaWebView css:'button[class=\"deregister-btn hidden\"]'","textContent")
  $i = 0
  $device_count = ele.count
  while $i < $device_count do
    puts "Then I see #{ele[$i]}"
    $i +=1
  end
    @calabash.touch("CordovaWebView css:'li[id=\"ember391\"]'")
    @calabash.performAction('click_on_text','Yes')
  else
    @calabash.screenshot_and_raise "There are no devices found to deregister"
  end
end

def is_deregistered?
  sleep(STEP_PAUSE)
  ele_after = @calabash.query("CordovaWebView css:'button[class=\"deregister-btn hidden\"]'").count
  if ($device_count == ele_after)
  @calabash.screenshot_and_raise "Unable to deregister"
  else
    puts "deregister done"
  end
end

def dkit_settings
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'.preference_icon'")
    @calabash.touch("CordovaWebView css:'.preference_icon'")
  else
    @calabash.screenshot_and_raise "Unable to find the preference_icon in setting's page"
  end
end

def deregister_icon
    sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'.deregister_icon'")
    sleep(STEP_PAUSE)
    @calabash.performAction('click_on_text','Yes')
end

def close
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'input[class=\"close-btn\"]'")
    @calabash.touch("CordovaWebView css:'input[class=\"close-btn\"]'")
  else
    @calabash.screenshot_and_raise "Unable to find Manage Devices in setting's page"
  end
end

def preview_on
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'label[class=\"onoffswitch-label\"]'")
    @calabash.touch("CordovaWebView css:'label[class=\"onoffswitch-label\"]'")
  else
    @calabash.screenshot_and_raise "Unable to find the preference_icon ON in setting's page"
  end
end

def close_preference
  sleep(STEP_PAUSE)
  if @calabash.element_exists("CordovaWebView css:'input[class=\"close-btn\"]'")
    @calabash.touch("CordovaWebView css:'input[class=\"close-btn\"]'")
  else
    @calabash.screenshot_and_raise "Unable to find the Close Button in preference setting's page"
  end
end

def deregistered?
  if @calabash.element_exists("CordovaWebView css:'#loginBtn'")
    puts "User Deregister Successfully"
  else
    @calabash.screenshot_and_raise "Unable to Deregister"
  end
end
def user_name_display

    if @calabash.element_exists("CordovaWebView css:'.user_icon'")
      @calabash.touch("CordovaWebView css:'.user_icon'")
    puts "user_name_displaying Successfully"
  else
    @calabash.screenshot_and_raise "Unable to Display"
  end
end
end

