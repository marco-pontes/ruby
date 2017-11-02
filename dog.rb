class Dog < Pet

  def bark
    puts "Woof"
  end


  def bark
    puts "Aoof"
  end


  def bark(i)
    i.times do
      puts "Woof"
    end
  end

  def talk()
    return "Woof"
  end

  def say(a, b, c)
    print a + " Woof " + b + " Woof " + c
    puts
  end
end