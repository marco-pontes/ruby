class Parent
  P_constant = 3
  def initialize(name)
    @name = name
  end

  def method1
    puts "hello parent class method1"
  end

  def method2
    puts "hello parent class method2"
  end

  def get_name
    @name
  end
end