When /^I add note with text "(.*?)"$/ do |text|
 book.add_note(text)
end

Then /^I should see the note "(.*?)"$/ do |text|
  screenshot_and_raise "The note is not matching" unless book.get_note == text
end


Then /^verify page has no highlighted note$/ do
   screenshot_and_raise "Page contains highlighted text" unless book.has_highlighted_note
end

Then /^verify page has no highlighted note in title$/ do
   screenshot_and_raise "Page contains highlighted text" unless book.title_has_highlighted_note
end

When /^student add note "(.*?)" to first sentence in the page$/ do |note|
  book.select_first_sentence
  steps %Q{And I press "Note"}
  book.add_note(note)
end

When /^student add note "(.*?)" to title$/ do |note|
  book.select_title
  steps %Q{And I press "Note"}
  book.add_note(note)
end

When /^student update note "(.*?)" to title$/ do |note|
  book.select_title
  steps %Q{And I press "Note"}
  book.update_note(note)
end

When /^student update note "(.*?)" to first sentence in the page$/ do |note|
  book.select_first_note
  steps %Q{And I press "Note"}
  book.update_note(note)
end

Then /^title has note as "(.*?)"$/ do |note|
 book.select_title
 steps %Q{And I press "Note"}
 screenshot_and_raise "The notes are not matching" unless book.get_note == note
end


Then /^first sentence has note as "(.*?)"$/ do |note|
 book.select_first_sentence
 steps %Q{And I press "Note"}
 screenshot_and_raise "The notes are not matching" unless book.get_note == note
end

When /^student open note and delete$/ do
  book.select_title
  steps %Q{And I press "Note"}
  book.delete_note
end
