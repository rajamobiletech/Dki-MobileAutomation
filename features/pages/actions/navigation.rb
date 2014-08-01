module Actions
  module Navigation
    def turn_next
      @calabash.performAction('drag',99,1,50,50,5)
      sleep(STEP_PAUSE + STEP_PAUSE)
    end

    def turn_faster
      @calabash.playback "fast_swipe"
    end

    def turn_previous
      sleep(2)
      @calabash.performAction('drag',1,99,50,50,5)
      sleep(STEP_PAUSE)
    end

    def turn_to_page(title)
      titleDiv=get_title_element
      until !titleDiv.nil? && titleDiv["textContent"].strip.eql?(title)
         if titleDiv.nil?
           @calabash.step "take picture" if @calabash.query("webView iframe:'#{current_page}|*'").length == 0
         end
         turn_next
         sleep(0.8)
        titleDiv = get_title_element
      end
    end
  end
end
