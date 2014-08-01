require 'yaml'
class Book
  attr_accessor :bookname,:current_page,:current_title,:searchkey

  def initialize(name,key='cisco')
    @bookname=name
    @searchkey=key
  end

  def self.get_book(book)
    path =File.dirname(__FILE__) + '/../Config/books.yaml'
    books = YAML.load_file(path)
    Book.new(books[book]["bookname"],books[book]["searchkey"])
  end

end
