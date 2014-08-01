Then /^(?:|student)(?:|I) select the first sentence$/ do
  book.select_first_sentence
end

Given /^that the page has title$/ do
 if book.get_title_element.nil?
        steps %Q{When student turn next page}
 end
end

When /^student highlight first sentence in the page$/ do
  book.select_first_sentence
  steps %Q{And I press "Highlight"}
end

When /^student highlighted title of the page$/ do
  if book.title_has_highlighted_note?
    steps %Q{When student open note and delete}
  end
    book.select_title
  steps %Q{And I press "Highlight"}
end

Then /^first sentence should be highlighted in the page$/ do
   screenshot_and_raise "Unable to find highlighted text in first sentence" unless book.first_sentence_highlighted?
end

Then /^title should be highlighted in the page$/ do
   screenshot_and_raise "Unable to find highlighted text in title" unless book.title_highlighted?
   @highted_title = book.get_highlighted_title
end


Then /^I should see highlighted text with note "(.*?)"$/ do |text|
  screenshot_and_raise "Unable to find highlighted text with note" unless book.get_highlight_text_index(text,true) >= 0
end

Then /^verify the highlighted text contains "(.*?)"$/ do |text|
  sleep(STEP_PAUSE)
  screenshot_and_raise "Text is not highlighted" unless book.highlighted?(text)
end

And /^there is no highlighted text in the page$/ do
  sleep(STEP_PAUSE)
  book.remove_all_highlights
end

When /^student remove highlight$/ do
  sleep(STEP_PAUSE)
  book.remove_first_hightlight
end

Then /^I select last row of the table$/ do
  book.select_last_row
end

When /^student highlight last row of the table$/ do
   book.select_last_row
   steps %Q{And I press "Highlight"}
end

When /^student highlight first row of the table$/ do
   book.select_first_row
   steps %Q{And I press "Highlight"}
end

Then /^last row of the table should be highlighted$/ do
  screenshot_and_raise "Unable to find highlighted text in last row of the table" unless book.last_row_highlighted?
end

Then /^first row of the table should be highlighted$/ do
  screenshot_and_raise "Unable to find highlighted text in last row of the table" unless book.first_row_highlighted?
end

Then /^I tap on highlighted text contains "(.*?)"$/ do |text|
  screenshot_and_raise "Unable to find highlighted text #{text}" unless book.highlighted?(text)
  book.tap_highlighted_text(text)
end

Then /^verify the text "(.*?)" is not highlighted$/ do |text|
  screenshot_and_raise "The text is highlighted - #{text} " if book.highlighted?(text)
end

Then /^I tap on the page$/ do
  steps %Q{Then I touch on screen 100 from the left and 250 from the top}
end

Then /^extend the selection$/ do
  book.extend_highlight
end

Then /^verify page has no highlighted text$/ do
   screenshot_and_raise "Page contains highlighted text" unless book.has_highlighted_content
end

Then /^verify title has no highlighted text$/ do
   screenshot_and_raise "Page contains highlighted text" if book.has_highlighted_title?
end

When /^student remove highlight from first sentence$/ do
  book.remove_first_hightlight
end

When /^student remove highlight from title$/ do
  book.remove_title_highlight
end

Then /^first sentence is not highlighted in the page$/ do
  screenshot_and_raise "first sentence has highlighted text" if book.first_sentence_highlighted?
end

Then /^title is not highlighted in the page$/ do
  screenshot_and_raise "title has highlighted text" if book.title_highlighted?
end

Then /^verify title has no highlighted note$/ do
  screenshot_and_raise "The title has notes" if book.title_has_highlighted_note?
end

When /^student extend the highlight$/ do
  @highlight_count = book.highlighted_count
  book.select_first_sentence
  book.extend_highlight
  steps %Q{And I press "Highlight"}
end

Then /^verify that the highlight is extended$/ do
  screenshot_and_raise "Highlight is not extended"  unless  book.highlighted_count >  @highlight_count
end
