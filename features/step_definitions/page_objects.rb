def home
  @home || HomePage.new(self)
end

def book
  @book || BookPage.new(self)
end

@searched = false
@rotate=false
