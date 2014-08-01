module Actions
  module Toc
     def open_toc
      sleep(STEP_PAUSE)
      @calabash.touch("CordovaWebView css:'div #page_container'")
      log("open_toc first touch")
      sleep(STEP_PAUSE)
      #if @calabash.label("button").include? "Remove Highlight"
        #@calabash.steps %Q{And I press "Remove Highlight"}
        #sleep(STEP_PAUSE)
       # @calabash.touch("CordovaWebView css:'*'")
       # sleep(STEP_PAUSE)
      #end
      @calabash.touch("CordovaWebView css:'a#contents_section_link'")
      sleep(2)
    end

    def toc_displayed?
      sleep(STEP_PAUSE)
      @calabash.element_exists("CordovaWebView css:'#toc_header'")
    end
    def press_resume_reading
      @calabash.touch("CordovaWebView css:'a#contents_section_link.resume-reading'")
       sleep(STEP_PAUSE)
    end
    def tap_content
      right = @calabash.query("webView css:'div#reader'").first["rect"]["right"]
      @calabash.touch(nil,:offset => {:x => right-10, :y => 100})
      sleep(1)
    end

    def select_page(page_number)
       @calabash.touch(@calabash.query("CordovaWebView css:'em.page-no'")[page_number])
       sleep(STEP_PAUSE + STEP_PAUSE)
       @calabash.steps %Q{When student turn next page}
       sleep(STEP_PAUSE)
       @calabash.steps %Q{When student turn next page}
       sleep(STEP_PAUSE)
       @calabash.steps %Q{When student turn previous page}
       sleep(STEP_PAUSE)
       @calabash.steps %Q{When student turn previous page}
       sleep(STEP_PAUSE)
    end

    def select_toc_item(link)
      link_index = get_toc_link(link)
      @calabash.screenshot_and_raise "Unable to find link in Toc" if link_index  == -1
      @calabash.touch(@calabash.query("CordovaWebView css:'div#contents_wrapper div span'")[link_index])
      sleep(STEP_PAUSE + STEP_PAUSE)
    end

    def get_page(page_number)
      toc_link = @calabash.query("CordovaWebView css:'div#contents_wrapper div span'")
      toc_link[page_number]["textContent"]
    end

    def open_non_bookmarked_page
      toc_link = @calabash.query("CordovaWebView css:'div#contents_wrapper div:not(.hasBookmark) span'")
      toc_link[0]["textContent"].strip
    end

    def open_bookmarked_page
      toc_link = @calabash.query("CordovaWebView css:'div#contents_wrapper div.hasBookmark span'")
      toc_link[0]["textContent"].strip
    end

    def get_toc_link(title)
      toc_links = @calabash.query("CordovaWebView css:'div#contents_wrapper div span'")
      link_index=-1
      toc_links.each_with_index do |link,index|
        if link["textContent"].strip == title
          link_index=index
          break
        end
      end
      link_index
    end

########################################################################################################################
    #somashekar
    def open_bookmark_toc
      sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'span.bookmark-icon'")
        @calabash.touch("CordovaWebView css:'span.bookmark-icon'")
      else
        @calabash.screenshot_and_raise "Unable to find the Bookmark toc icon"
      end
    end

    def is_bookmark_list
      sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'span.page-head-title'")
        return "List of Bookmark pages is present"
      else
        return "List of Bookmark pages is not present"
      end
    end

    def open_edit_title
      sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'#editTitle'")
        @calabash.touch("CordovaWebView css:'a[id=editTitle]'")
      else
        @calabash.screenshot_and_raise "Unable to find the Edit Bookmark title in toc"
      end
    end

    def update_title (text)
      sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'input[id=titleInput]'")
         #textbfr = set_text("CordovaWebView css:'input[id=titleInput]'",text)
         @calabash.performAction("set_text",'CordovaWebView css','input[id=titleInput]',text)
         #textbfr = @calabash.query("CordovaWebView css:'input[id=titleInput]','value'").first
         #puts textbfr
         sleep(STEP_PAUSE)
      else
        @calabash.screenshot_and_raise "Unable to find the Title input field in toc"
      end
    end

    def save_title
      sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'#saveTitle'")
        @calabash.touch("CordovaWebView css:'a[id=saveTitle]'")
      else
        @calabash.screenshot_and_raise "Unable to find the Save Bookmark title in toc"
      end
    end

    def updated?
      sleep(STEP_PAUSE)
      @calabash.query("CordovaWebView css:'input[id=titleInput]'").each do |ele|
        if ele["value"].strip == "New title"
          return "Updated Successfully"
        else
          @calabash.screenshot_and_raisefalse "Update Failed"
        end
        end
    end

    def remove_bookmark
      sleep(STEP_PAUSE)
      if @calabash.element_exists("CordovaWebView css:'#removeBookmark'")
        ele = @calabash.query("CordovaWebView css:'input[id=titleInput]','value'")
        elebefore = ele.first
        @calabash.touch("CordovaWebView css:'a[id=removeBookmark]'")
      else
        @calabash.screenshot_and_raise "Unable to find the Remove Bookmark title in toc"
      end
    end

    def is_remove_bookmark
      ele = @calabash.query("CordovaWebView css:'input[id=titleInput]','value'")
      eleaft = ele.first
      if elebefore == eleaft
        @calabash.screenshot_and_raisefalse "Update Failed"
      else
          return "Updated Successfully"
      end
    end
    #  countafter = @calabash.element_exists("CordovaWebView css:'#removeBookmark'").count
    #   if countbfr == countafter
    #     @calabash.screenshot_and_raise "unsuccessful"
    #   else
    #     return "success"
    #   end
    # end
  end
end
