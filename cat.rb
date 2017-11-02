require './module.rb'
class Cat < Pet
  include NumberUtility
  def talk()
    return "Meow"
  end
end