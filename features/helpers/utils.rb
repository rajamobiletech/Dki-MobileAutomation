def keyboard_enter_text (field,value)
  @calabash.performAction("set_text",'css',field, value)
end

def enter_text_for_note(command, text)

  if(text.is_a? String)
    text = text.gsub(/([^ws])/){ |c| '\\' + c }
   text = text.gsub! ' ', '%s'
  end
  command = "adb shell input #{command} #{text}"
  system(command)
end