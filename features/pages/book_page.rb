require File.dirname(__FILE__) + '/actions/toc'
require File.dirname(__FILE__) + '/actions/highlight'
require File.dirname(__FILE__) + '/actions/navigation'

class BookPage < BasePage
  include Actions::Toc
  include Actions::Highlight
  include Actions::Navigation
  include Actions::Search

  def page_title
    sleep(STEP_PAUSE)
    @divName=Array["containerTitle","Topic_Title","creditTitle","Title_Procedure",]
    @index = 0
    titleDiv = @calabash.query("CordovaWebView iframe:'#{current_page}|div.#{@divName.at(@index)}'","textContent").first
    #titleDiv
    titleDiv.empty?  ?  find_title : titleDiv["textContent"]
  end

  def find_title
    get_title_element.empty ? "" :get_title_element["textContent"]
  end

  # def find_title
  #   get_title_element.nil ? "" : get_title_element["textContent"]
  # end

  def container_title
    sleep(STEP_PAUSE)
    begin
      puts @calabash.query("CordovaWebView iframe:'#{current_page}|div.#{@divName.at(@index)}'").first
      @calabash.query("CordovaWebView iframe:'#{current_page}|div.#{@divName.at(@index)}'").first
    rescue
      @index+= 1
      retry
    end
  end

  def header_visible?
    @calabash.query("CordovaWebView css:'a#back_to_link'").count > 0
  end

  def page_visible?
    @calabash.query("CordovaWebView css:'div#monocle_reader'").count > 0
  end

  def highlight_note_visible?
    @calabash.query("CordovaWebView css:'input.cancel-btn'").count > 0
  end

  def handle_if_highlight_note_visible
    @calabash.query("CordovaWebView css:'input.cancel-btn'").count > 0
    @calabash.touch("CordovaWebView css:'input.cancel-btn'")
    sleep(1)
  end

  def go_to_library
    sleep(STEP_PAUSE)
      @calabash.touch("CordovaWebView css:'div #page_container'")
      sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'a#back_to_link'")
    sleep(STEP_PAUSE)
  end

  def tap_bookmark
    sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'a#bookmark'")

    sleep(2)
  end

  def page_bookmarked?
    sleep(STEP_PAUSE)
   !@calabash.query("CordovaWebView css:'a#bookmark.bookmarked'").empty?
  end

  def navigate_to_page(page_number)
    open_toc
    sleep(STEP_PAUSE)
    select_page(page_number)
    sleep(STEP_PAUSE)
    current_page = get_page_number
    puts "#{current_page}"
    puts "#{page_number}"
    puts "srs"
    if current_page == page_number
    #@calabash.screenshot_and_raise "Unable to open the page #{page_number} but was #{current_page}" unless current_page == page_number
    @calabash.touch("CordovaWebView css:'div #page_container'")
    sleep(STEP_PAUSE)
    if @calabash.query("CordovaWebView css:'#controls_top_bar'")[0]["rect"]["height"] > 0
      @calabash.touch("CordovaWebView css:'div #page_container'")
    end
    else
      puts "not matching"
    end
  end

  def get_page_number(reset=false)
    sleep(STEP_PAUSE + STEP_PAUSE)
    if @calabash.query("android.view.View marked:'page_info_page_number'").count > 0
      @calabash.touch("CordovaWebView css:'div#page_container'")
      sleep(STEP_PAUSE)
      if @calabash.query("android.view.View marked:'removeHighlight'").count > 0
        @calabash.touch(@calabash.query("android.view.View marked:'removeHighlight'"))
        sleep(STEP_PAUSE)
        @calabash.touch("CordovaWebView css:'div#page_container'")
        sleep(STEP_PAUSE + STEP_PAUSE)
      end
      sleep(STEP_PAUSE)
      @calabash.screenshot_and_raise "Unable to read page number" if  @calabash.query("android.view.View marked:'page_info_page_number'").count == 0
    end
    page = @calabash.query("android.view.View marked:'page_info_page_number'","text")
    page_number = page.first
    puts page_number
    number = /\d+/.match(page_number)
    if(reset)
    @calabash.touch("CordovaWebView css:'div #page_container'")
    @calabash.steps %Q{When I tap on the page}
    sleep(STEP_PAUSE)
    end
    number.to_i
  end

  def move_slider_to_end
    sleep(STEP_PAUSE)
     slider = @calabash.query("webView css:'div#page_slider'").first
     x = slider["rect"]["right"] - slider["rect"]["center_x"] - 10
     @calabash.touch("webView css:'div#page_slider'", :offset => {:x => x,:y=> 1})
      sleep(STEP_PAUSE)
  end

  def move_slider_to_begin
    sleep(STEP_PAUSE)
     slider = @calabash.query("webView css:'div#page_slider'").first
     x = slider["rect"]["left"] - slider["rect"]["center_x"] - 10
     @calabash.touch("webView css:'div#page_slider'", :offset => {:x => x,:y=> 1})
      sleep(STEP_PAUSE)
  end

    def get_title_element
      begin
      @calabash.query("CordovaWebView iframe:'#{current_page}|div.Topic_Title'").first
      sleep(STEP_PAUSE)
      rescue StandardError=>e
        if (e)
          return false
          end
        end
    end
end
