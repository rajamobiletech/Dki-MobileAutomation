require 'yaml'

class User
  attr_accessor :username, :password

  def initialize(name,password)
    @username=name
    @password=password
  end

  def self.get_default_user
    self.get_user("default")
  end

  def self.get_user(user)
    path =File.dirname(__FILE__) + '/../Config/users.yaml'
    users = YAML.load_file(path)
    User.new(users[user]["username"],users[user]["password"])
  end

end

# puts User.get_user(ENV['DKIT_USER'] || "default").username
