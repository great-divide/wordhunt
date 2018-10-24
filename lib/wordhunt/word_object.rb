class Wordhunt::Word_object
	attr_accessor :name, :count, :sentences

  def initialize(name)
    @name = name
    @sentences = []

  end

end