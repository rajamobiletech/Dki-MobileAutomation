module Actions
  module Search
    def search(key)
      sleep(STEP_PAUSE)
      @calabash.touch("CordovaWebView css:'*'")
      sleep(STEP_PAUSE)
      @calabash.touch("CordovaWebView css:'input#searchTextField'")
      sleep(2) #Wait for keyboard to appear
      @calabash.performAction("set_text",'css','input[id=searchTextField]',key)
      @calabash.performAction('send_key_enter')
      sleep(4)
    end

    def search_results
      sleep(10)
      result_div = @calabash.query("CordovaWebView css:'div#search_results_wrapper'")
      @calabash.screenshot_and_raise "Search result is not displayed" unless result_div.count > 0
      SearchResult.new(@calabash)
      #return result_div
    end

    # def search_results?
    #     result_search_div = @calabash.query("CordovaWebView css:'div#search_results_wrapper'","textContent").count
    #     if  result_search_div < 0
    #       @calabash.screenshot_and_raise "Search result is not displayed" #unless result_div.count < 0
    # end
    # end
  end
  end