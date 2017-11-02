class Subclass < Parent
  P_constant = 4
  def method2
    puts "hello subclass method2"
  end

  def get_name()
    super + "subclass"
  end
end