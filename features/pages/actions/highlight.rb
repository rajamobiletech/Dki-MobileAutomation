module Actions
  module Highlight


    def get_highlight_coordinate(rect)
      #/ This method calculates the coordinates required to do a selection.
      # This is required, as the architecture has phone screen, viewports and iframes
      # Calabash returns the coordinates based on the viewport when a element is queried
      # In our case elements are present inside the iframe
      # What we are doing is calculating the the coordinates wrt to the parent screen
      coordinate_arr= Array.new(2)
      top = rect["rect"]["top"]
      height = rect["rect"]["height"]
      coordinate_arr[0] = 42 * 1.5
      coordinate_arr[1] = (55 + 14 + top + (height/2) ) * 1.5
      return coordinate_arr
    end

     def get_note
    sleep(STEP_PAUSE)
    note=@calabash.query("CordovaWebView css:'textarea#noteField'");
    note_text= note[0]["value"]
    @calabash.touch("CordovaWebView css:'input.cancel-btn'")
    note_text
  end

  def add_note(txt)
    sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'textarea#noteField'")
    sleep(STEP_PAUSE + STEP_PAUSE)
    note=@calabash.query("CordovaWebView css:'textarea#noteField'")
    note_text= note[0]["value"]
    note_text.length.times do
    enter_text_for_note('keyevent',67)
  end
    @calabash.touch("CordovaWebView css:'textarea#noteField'")
    sleep(STEP_PAUSE)
    enter_text_for_note('text',txt)
    sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'input.save-btn'")
    sleep(STEP_PAUSE)
  end

  def update_note(txt)
    sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'textarea#noteField'")
    sleep(STEP_PAUSE + STEP_PAUSE)

    enter_text_for_note('text',txt)
    sleep(STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'input.save-btn'")
    sleep(STEP_PAUSE)
  end

  def delete_note
    sleep(STEP_PAUSE + STEP_PAUSE)
    @calabash.touch("CordovaWebView css:'button.delete-btn'")
    sleep(STEP_PAUSE)
  end

    def select_first_sentence
      begin
      if  @calabash.query("CordovaWebView iframe:'#{current_page}|div.ParagraphType.ParaBlock > div.Wysiwyg'").count == 0
        @calabash.steps %Q{When student turn next page}
      end
      rescue StandardError => e
        if(e)
          @calabash.steps %Q{When student turn next page}
        end
      end
      if @calabash.query("CordovaWebView css:'#controls_top_bar'")[0]["rect"]["height"] > 0
        @calabash.touch("CordovaWebView css:'div #page_container'")
        sleep(STEP_PAUSE + STEP_PAUSE)
      end
        xy_coordinates = Array.new(2)
      rect = @calabash.query("CordovaWebView iframe:'#{current_page}|div.ParagraphType.ParaBlock > div.Wysiwyg'")[0]
      xy_coordinates = get_highlight_coordinate(rect)
      sleep(STEP_PAUSE)
      @calabash.performAction('long_press_coordinate', xy_coordinates[0],xy_coordinates[1])
      sleep(STEP_PAUSE)
    end

    def select_first_note
      if  @calabash.query("webView iframe:'#{current_page}|span.highlighted.highlightHasNote'").count == 0
        @calabash.screenshot_and_raise "Unable to find the note in this page"
      end
      @calabash.playback "text_selection",{:query => "webView iframe:'#{current_page}|span.highlighted.highlightHasNote' index:0"}
      sleep(STEP_PAUSE)
    end

    def select_title
      if get_title_element.nil?
         @calabash.steps %Q{When student turn next page}
      end
      #if @calabash.query("CordovaWebView css:'#controls_top_bar'")[0]["rect"]["height"] > 0
      #  @calabash.touch("CordovaWebView css:'div #page_container'")
      #  log("select title - sixth touch")
      #  sleep(STEP_PAUSE + STEP_PAUSE)
      #end

      rect = @calabash.query("CordovaWebView iframe:'#{current_page}|div'").find{|x|x["class"] =~ /Title/}

      until rect["class"] == "Topic_Title" do
      rect = @calabash.query("CordovaWebView iframe:'#{current_page}|div'").find{|x|x["class"] =~ /Title/}
      @calabash.steps %Q{When student turn next page}
      end

      xy_coordinates = gethighlight_Coordinate(rect)
      sleep(STEP_PAUSE)
      @calabash.performAction('long_press_coordinate', xy_coordinates[0],xy_coordinates[1])
      sleep(STEP_PAUSE + STEP_PAUSE)

    end


    def first_sentence_highlighted?
      text = @calabash.query("CordovaWebView iframe:'#{current_page}|div.ParagraphType.ParaBlock > div.Wysiwyg'")[0]["textContent"]
      spans = @calabash.query("CordovaWebView iframe:'#{current_page}|div.ParagraphType.ParaBlock span.highlighted'")
      return false if spans.count == 0
      text.strip.include? spans[0]["textContent"].strip
    end

    def title_highlighted?
       sleep(STEP_PAUSE)
       begin
       @calabash.query("CordovaWebView iframe:'#{current_page}|div.Topic_Title span.highlighted'").count > 0
       rescue StandardError => e
         if(e)
           return false
           end
         end
       end

    def get_row_count
      @calabash.screenshot_and_raise "There is no table in the page" if @calabash.query("CordovaWebView iframe:'#{current_page}|table'").count == 0
      @calabash.query("CordovaWebView iframe:'#{current_page}|table tr'").count
    end

    def select_table_row(index)
      #@calabash.playback "text_selection",{:query => "webView iframe:'#{current_page}|tr' index:#{index}"}
    end

    def select_first_row
      count=get_row_count
      select_table_row(0)
    end

    def select_last_row
      count=get_row_count
      select_table_row(count-1)
    end

    def first_row_highlighted?
     count=get_row_count
     text = @calabash.query("webView iframe:'#{current_page}|tr' index:0")[0]["textContent"]
     rows = @calabash.query("webView iframe:'#{current_page}|tr span.highlighted'")
     return false if rows.count == 0
     text.strip.include? rows[0]["textContent"].strip
   end

   def last_row_highlighted?
     count=get_row_count
     text = @calabash.query("webView iframe:'#{current_page}|tr' index:#{count-1}")[0]["textContent"]
     rows = @calabash.query("webView iframe:'#{current_page}|tr span.highlighted'")
     return false if rows.count == 0
     text.strip.include? rows[0]["textContent"].strip
   end

   def get_highlight_text_index(text,note=false)
    span=(note) ? "span.highlighted.highlightHasNote" : "span.highlighted"
    highlighted_elements = @calabash.query("webView iframe:'#{current_page}|#{span}'")
    highlighted_elements.each_with_index do |e,index|
      return index if e["textContent"].gsub(/\s+/, " ").strip.include? text
    end
    return -1
  end

  def highlighted_count
    @calabash.query("webView iframe:'#{current_page}|span.highlighted'").count
  end

    # Remove all highlights from the page
    def remove_all_highlights
      sleep(STEP_PAUSE)
      count = highlighted_count
      while highlighted_count > 0
        remove_first_hightlight
       #  element= @calabash.query("webView iframe:'#{current_page}|span.highlighted'").first
       #  if element["textContent"].length < 10
       #    puts "----------------"
       #    @calabash.pinch("in")
       #    sleep(STEP_PAUSE + STEP_PAUSE)
       #    @calabash.pinch("in")
       #    sleep(STEP_PAUSE + STEP_PAUSE)
       #  end
       #  elements= @calabash.touch("webView iframe:'#{current_page}|span.highlighted'",:offset => {:x => 5, :y => 5})
       #  sleep(1)
       #  @calabash.steps %Q{And I press "Remove Highlight"} if @calabash.label("button").include? "Remove Highlight"
       # if elements[0]["class"].include? "highlightHasNote"
       #    sleep(STEP_PAUSE + STEP_PAUSE)
       #   @calabash.touch("button index:1") if @calabash.query("button").count > 0
       # end
       # if element["textContent"].length < 10
       #    @calabash.pinch("out")
       #    sleep(STEP_PAUSE + STEP_PAUSE)
       #    @calabash.pinch("out")
       #    sleep(STEP_PAUSE + STEP_PAUSE)
       # end
       count-= 1
     end
   end

   def remove_title_highlight
      sleep(STEP_PAUSE)
      begin
         @calabash.query("CordovaWebView iframe:'#{current_page}|div.Topic_Title span.highlighted'").count == 0
      rescue StandardError => e
      if(e)
        return
      end
      end

      rect = @calabash.query("CordovaWebView iframe:'#{current_page}|div.Topic_Title span.highlighted'")[0]
      xy_coordinates = gethighlight_Coordinate(rect)
      sleep(STEP_PAUSE)
      @calabash.performAction('touch_coordinate', xy_coordinates[0],xy_coordinates[1])
      sleep(STEP_PAUSE + STEP_PAUSE)

      if @calabash.query("android.view.View marked:'removeHighlight'")[0]["text"].include? "Remove Highlight"
          @calabash.touch(@calabash.query("android.view.View marked:'removeHighlight'"))
      end

      if rect["class"].include? "highlightHasNote"
        sleep(STEP_PAUSE + STEP_PAUSE)
        @calabash.touch("button marked:'Yes'") if @calabash.query("button").count > 0
      end
      sleep(STEP_PAUSE + STEP_PAUSE)

   end

   def remove_first_hightlight
    element= @calabash.query("webView iframe:'#{current_page}|span.highlighted'").first
        # if element["textContent"].length < 20
        #   @calabash.pinch("in")
        #   @calabash.pinch("in") if element["textContent"].length < 10
        #   sleep(STEP_PAUSE + STEP_PAUSE)
        # end
        elements=  @calabash.touch("webView iframe:'#{current_page}|span.highlighted'" ,:offset => {:x => 5, :y => 5})
        sleep(STEP_PAUSE + STEP_PAUSE)
        if @calabash.label("button").include? "Remove Highlight"
         @calabash.steps %Q{And I press "Remove Highlight"}
       else
        @calabash.steps %Q{When I tap on the page}
        sleep(STEP_PAUSE)
        elements=  @calabash.playback("tt",{:query => "webView iframe:'#{current_page}|span.highlighted' index:0",:offset => {:x=>5,:y=>5}})
        sleep(STEP_PAUSE + STEP_PAUSE)
        if @calabash.label("button").include? "Remove Highlight"
          @calabash.steps %Q{And I press "Remove Highlight"}
        else
         element["rect"]["center_x"].to_i.upto(element["rect"]["right"].to_i) do |index|
          newx= index - element["rect"]["center_x"].to_i
           @calabash.touch("webView iframe:'#{current_page}|span.highlighted'" ,:offset => {:x => newx, :y => 5})
           sleep(STEP_PAUSE + STEP_PAUSE)
           if @calabash.label("button").include? "Remove Highlight"
             @calabash.steps %Q{And I press "Remove Highlight"}
             break
           end
           @calabash.steps %Q{When I tap on the page}
         end
       end
     end
     if elements[0]["class"].include? "highlightHasNote"
      sleep(STEP_PAUSE + STEP_PAUSE)
      @calabash.touch("button index:1") if @calabash.query("button").count > 0
    end
    end

    def highlighted?(text)
      sleep(STEP_PAUSE)
      get_highlight_text_index(text) >= 0
    end

    def extend_highlight
      @calabash.playback("extend_selection")
    end

    def has_highlighted_content
     @calabash.query("webView iframe:'#{current_page}|span.highlighted'").count == 0
   end

    def has_highlighted_title?
      @calabash.query("webView iframe:'#{current_page}|div.Topic_Title span.highlighted'").count > 0
    end

   def has_highlighted_note?
     @calabash.query("webView iframe:'#{current_page}|span.highlighted.highlightHasNote'").count == 0
   end

   def get_highlighted_title
    @calabash.query("CordovaWebView iframe:'#{current_page}|div.Topic_Title span.highlighted'")[0]['textContent']
   end

   def title_has_highlighted_note?
    begin
     @calabash.query("CordovaWebView iframe:'#{current_page}|div.Topic_Title span.highlighted.highlightHasNote'").count > 0
    rescue StandardError=>e
      if (e)
        return false
        end
      end
   end

   def tap_highlighted_text(text)
    index = get_highlight_text_index(text);
    @calabash.touch("webView iframe:'#{current_page}|span.highlighted' index:#{index}")
    sleep(STEP_PAUSE + STEP_PAUSE)
  end
end
end
