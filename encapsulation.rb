class Encapsulation
  def initialize(name)
    set_name(name)
  end

  def name()
    @first_name + ' ' + @last_name
  end

  private #everything down is private
  def set_name(name)
    first_name, last_name = name.split(/\s+/)
    set_first_name(first_name)
    set_last_name(last_name)
  end

  def set_first_name(first_name)
    @first_name = first_name
  end

  public #back to public
  def set_last_name(last_name)
    @last_name = last_name
  end

  protected
  def get_last_name()
    @last_name
  end
  #another way of declaring private/public
  private(:set_name, :set_first_name)
  public(:set_last_name)
  protected(:get_last_name)

  #more than one command using semicolon ';'
  private(:set_name, :set_first_name); public(:set_last_name)


end

e = Encapsulation.new("Marco Pontes")
e2 = Encapsulation.new("Tamiris Pontes")
puts e.name()
#e.set_first_name("AAA") `<top (required)>': private method `set_first_name' called
e.set_last_name("Bridges")
puts "fork: "+ e.name()
#puts e.get_last_name() : protected method `get_last_name'
