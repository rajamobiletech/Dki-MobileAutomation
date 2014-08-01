class SearchResult
  def initialize(c)
   @calabash = c
  end

  def include_title?(title)
    titles = @calabash.query("CordovaWebView css:'ul#results_listing li a p strong'")
    titles.each do |t|
      return true if t["textContent"] == title
    end
    return false
  end

  def all_contains?(content)
    titles = @calabash.query("CordovaWebView css:'ul#results_listing li:not(.indexing-text) h4'")
    titles.each do |t|
       return true if t["textContent"].downcase.include?(content.downcase)
    end
    else
    return false
  end

  def count
    @calabash.query("CordovaWebView css:'ul#results_listing li h4'").count
  end

  def empty?
    count == 0
  end

  def filter_result(filter)
    sleep(STEP_PAUSE+STEP_PAUSE)
    control=""
   case filter.downcase
    when "all"
      control = "li#filter_all"
    when "content","contents"
      control = "li#filter_content"
    when "note","notes"
      control = "li#filter_note"
    when "highlight","highlights"
      control = "li#filter_highlight"
   end
   @calabash.touch("CordovaWebView css:'#{control}'")
    sleep(STEP_PAUSE+STEP_PAUSE)
  end

  def get_page_number(index)
    @calabash.query("CordovaWebView css:'ul#results_listing li a p em'")[index]["textContent"]
  end

  def get_page_title(index)
    @calabash.query("CordovaWebView css:'ul#results_listing li a p strong'")[index]["textContent"].strip
  end

  def select_result(index)
     @calabash.touch(@calabash.query("CordovaWebView css:'ul#results_listing li a'")[index])
  end

  def contains_title?(title)
    titles = @calabash.query("CordovaWebView css:'ul#results_listing li a p strong'")
    titles.each_with_index do |t,index|
       if t["textContent"] == title
        return true
       end
    end
    return false
  end

  def select_snippet(text)
    snippets = @calabash.query("CordovaWebView css:'ul#results_listing li h4'")
    snippets.each_with_index do |s,index|
       if t["textContent"].strip == text
        @calabash.touch("CordovaWebView css:'ul#results_listing li h4' index:#{index}")
        return
      end
    end
     @calabash.screenshot_and_raise "search result not contains snippet :#{text}"
  end

  def select_title(title)
    titles = @calabash.query("CordoivaWebView css:'ul#results_listing li a p strong'")
    titles.each_with_index do |t,index|
      if t["textContent"] == title
        @calabash.touch("CordovaWebView css:'ul#results_listing li a' index:#{index}")
        return
      end
    end
      @calabash.screenshot_and_raise "search result not contains title :#{title}"
  end
end
