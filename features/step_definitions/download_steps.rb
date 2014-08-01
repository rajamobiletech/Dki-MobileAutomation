When /^student download the book$/ do
  sleep(STEP_PAUSE)
  @searched = false # retset the searched flag
  @book_data = Book.get_book(ENV['DKIT_BOOK'] || "default")
  home.download_book(@book_data.bookname,wait_finish=true)
  screenshot_and_raise "Unable to find downloaded book with title - #{@book_data.bookname} " unless home.downloaded?(@book_data.bookname)
end

When /^student started downloading the book$/ do
  sleep(STEP_PAUSE)
  @book_data = Book.get_book(ENV['DKIT_BOOK'] || "book1")
  home.download_book(@book_data.bookname,false)
end
When /^student started downloading the book2$/ do
  sleep(STEP_PAUSE)
  @book_data = Book.get_book(ENV['DKIT_BOOK'] || "book2")
  home.download_book(@book_data.bookname,false)
end

When /^student pause download$/ do
  home.pause_download(@book_data.bookname)
end

And /^student resume download$/ do
  home.resume_download(@book_data.bookname)
end

Then /^student should be able see downloading after resume$/ do
  screenshot_and_raise "There are no books in resume downloading status" unless home.download_resume?
end

And /^student cancel download$/ do
  home.cancel_download
end

Then /^I should be able to see the book after cancel$/ do
  home.download_canceled?
end

Then /^student should see download paused$/ do
  screenshot_and_raise "There are no books in paused download status" unless home.download_paused?
end

 Then /^student (?:|should be able to )open the book$/ do
  @book_data = Book.get_book(ENV['DKIT_BOOK'] || "default")
   unless home.downloaded?(@book_data.bookname)
    steps %Q{When student download the book}
  end
  home.open_book(@book_data.bookname)
end

Then /^student should be able to open the book after resuming$/ do
  @searched = false
  @book_data = Book.get_book(ENV['DKIT_BOOK'] || "book1")
  unless home.downloaded?(@book_data.bookname)
    home.download_book(@book_data.bookname,wait_finish=true)
	screenshot_and_raise "Unable to find downloaded book with title - #{@book_data.bookname} " unless home.downloaded?(@book_data.bookname)
  end
  home.open_book(@book_data.bookname)
end

Given /^that there is a book to download$/ do
  screenshot_and_raise "There are no books available to download" unless home.downloadable_books.count > 0
end

When /^I download the book with title "(.*?)"$/ do |title|
  home.download_book(title)
end

When /^download and open the book "(.*?)"$/ do |title|
  sleep(STEP_PAUSE)
  unless home.downloaded?(title)
    steps %Q{When I download the book with title "#{title}"}
  end
  steps %Q{When open the book "#{title}"}
end

Then /^verify the book with title "(.*?)" has been downloaded$/ do |title|
  screenshot_and_raise "Unable to find downloaded book with title - #{title} " unless home.downloaded?(title)
end

When /^open the book "(.*?)"$/ do |title|
  home.open_book(title)
end
When /^long press on the book "(.*?)"$/ do |book|
  home.long_tap(book)
end

And /^press remove button for book "(.*?)"$/ do |book|
  home.press_remove(book)
end

Then /^verify the book "(.*?)" has been removed$/ do |title|
  screenshot_and_raise "book with title - #{title} - is not deleted" if home.downloaded?(title)
end

Given /^student remove the book if downloaded$/ do
  if @book_data.nil?
    @book_data = Book.get_book(ENV['DKIT_BOOK'] || "default")
  end
  if home.downloaded?(@book_data.bookname)
    home.long_tap(@book_data.bookname)
    home.press_remove(@book_data.bookname)
  end
end

When /^student remove the book$/ do
  if @book_data.nil?
    @book_data = Book.get_book(ENV['DKIT_BOOK'] || "default")
  end
  home.long_tap(@book_data.bookname)
  home.press_remove(@book_data.bookname)
end

Then /^book should be ready for download$/ do
   screenshot_and_raise "Book is not there to download" unless home.ready_for_download?(@book_data.bookname)
end

When /^I am on Library Page$/ do
  assert(home.book_list?, "true")
end

