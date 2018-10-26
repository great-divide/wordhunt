class Wordhunt::Word
	attr_accessor :name, :count, :sentences

	@@all = []

  def initialize(name)
    @name = name
    @sentences = []
    @@all << self
  end

  def self.all
  	@@all
  end

  def self.find_by_name(name)
  	@@all.find { |n| n.name == name }
  end

end