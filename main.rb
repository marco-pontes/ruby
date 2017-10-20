load 'Pet.rb'
load 'Dog.rb'
def test()
  puts 'test procedural method'
  end
class Main
  Pi = 3.14
  def receiveFunc()
    puts 'method that executes a code block'
    yield("passed param")
  end

  def divide(x, y)
    puts x.to_f/y.to_f
  end

  def divideIntegers(x, y)
    puts x.to_i/y.to_i
  end

  def divideIntegers?(x, y)
    puts x.to_i/y.to_i
  end

  def main()
    basics()
    #Chapter 3: Data Expressions and flow control
    data_expressions_flow()
    #Strings
    strings()
    #Arrays and lists
    arrays()
    #Hashes
    hashes()
    #flow control
    flow_control()
  end

  def flow_control()
    age = rand(30)
    if(age > 18)
      puts "age > 18"
    end
    if age > 18
      puts "age > 18"
    end

    unless age > 18
      puts "age less than 18"
    end
    if age > 18
      puts "this is the if. Age greater than 18"
    else
      puts "this is the else. Age less than 18"
    end

    unless age > 18
      puts "this is the unless. Age less than 18"
    else
      puts "this is the else. Age greater than 18"
    end

    type = age > 18 ? 'adult' : 'child'
    puts type
  end

  def basics
    10.times do
      print "teste \n"
    end
    #print "2 + 3 is equal to " + 2 + 3
    #must convert to string first
    puts "2 + 3 is equal to: " + (2 + 3).to_s
    puts "integer arithmetic results in integer: " + (10/3).to_s
    puts "with a floating point: " + (10.0/3).to_s
    #Requires Dog and Pet to be included
    dog = Dog.new
    dog.bark 3
    dog.bark(3)
    #Fixnum is the number class in ruby
    puts (2.+(2))
    puts (2.class)
    puts (puts.class)
    puts (Kernel.class.to_s + Kernel.puts.class.to_s)
    dog.say("I", "want", "food")
    #String class
    puts "This is a test".class.to_s + "This is a test".length.to_s
    #method has to be defined before
    test()
    puts test.class
  end

  def data_expressions_flow
    x2 = 3
    #4h = 4 invalidputs("you are old enough") unless age < 18
    _3aa = 2
    _start_underscore = 3
    age = rand(28)
    puts("age " + age.to_s)
    age2 = rand(28)
    puts("age2 " + age2.to_s)
    #conditions
    puts("you are too young to enter") if age <= 12
    puts("you are old enough") unless age <= 18
    puts("you are a teenager") if age.between?(12, 17)
    puts("age <=> age2: " + (age <=> age2).to_s)
    #loops
    5.times do
      puts("aaaa")
    end
    5.times do |number|
      puts number
    end
    5.times do |number|
      puts number
    end
    5.times do |number|
      test
    end
    5.times {puts("test curly")}
    #if true {test()}
    5.upto(10) {|number| puts number}
    5.downto(0) {|number| puts number}
    0.step(50, 5) {|number| puts number}
    receiveFunc {|param| puts "aaaa Works " + param}
    divide(10, 3)
    divideIntegers(10.0, 3.0)
    #constant
    puts Pi
  end

  def strings
    s = %q(
      test'
      multi line"
      string
    )

    puts s

    s = <<STRING_TEST
      test
      testing"
      three lines'
STRING_TEST

    puts s
    s = "x"
    puts s.ord
    puts 120.chr
    x = 10
    y = 20
    s = "#{x} + #{y} = #{x + y}"
    puts s
    s = "#{x} + #{y} = #{x * y}"
    puts s
    x = "dog"
    y = "cat"
    s = "#{x} + #{y} = #{x + y}"
    puts s

    s = "#{x} * 8 = #{x * 8}"
    puts s
    puts "test".chop.chop
    puts "test".reverse
    puts "test".length
    puts "test".sub("est", "asty")
    puts "testtest".sub("est", "asty")
    puts "testtest".gsub("est", "asty")
    puts "testtest".sub(/\w{1}/, "tasti")
    puts "testtest".sub(/^\w/, "tasti")
    puts "testtest".sub(/\w$/, "tasty")
    "testtest".scan(/./) {|letter| puts letter}
    "this is a test".scan(/\w\w/) {|letter| puts letter}
    "this is a 10 test out of 1000".scan(/\d+/) {|digits| puts digits}
    "this is a test".scan(/[aeiou]/) {|letter| puts letter}
    puts ""
    "this is a test".scan(/[a-o]/) {|letter| puts letter}
    puts "match position: " + ("this is a test" =~ /[a]/).to_s
    puts "true?" if ("this is a test" =~ /[p]/)
    puts "ruby considers this as true?" if ("this is a test" =~ /[t]/)
    x = "This is a test".match(/(\w+)(\w+)/)
    puts x[0]
    puts x[1]
    puts x[2]
  end

  def arrays
    array = [1, 2, 3, 4, 5]
    puts array[0]
    array[0] += 1
    puts array.to_s
    array[0] = "test" * 3
    puts array.to_s
    array << "last"
    puts array.to_s
    array.push("last")
    puts array.to_s
    puts array.pop()
    puts array.to_s
    puts array.length
    puts array.size
    puts array.join()
    puts array.to_s
    puts array.join(", ")
    puts array.inspect
    array.each() {|element| puts element}
    array = array.collect() {|element| element * 2}
    puts array.inspect
    array = array.map() {|element| element * 2}
    puts array.inspect
    i = 0
    while (i < array.length)
      puts array[i]
      i += 1
    end
    array2 = [50, 90, 2000]
    array3 = array + array2
    p array3
    array3 = array3 - array
    p array3
    a = []
    puts "a empty? " + a.empty?.to_s
    puts "includes 50?" + array2.include?(50).to_s
    puts array2.first()
    puts array2.last()
    puts array2.last(2).to_s
    puts array2.reverse.to_s
  end

  def hashes
    dict = {2 => 3, 3 => 4, 11 => 10}
    puts dict[2]
    dict2 = {"name" => "Marco", "age" => 29, "gender" => "Masculino"}
    puts dict2["name"]
    #dict3 = dict. dict2
    #p dict3.size
    dict2.each {|key, value| puts "key: #{key}, value: #{value}"}
    puts dict2.keys
    puts dict2.values
    dict2.delete("name")
    puts dict2
    dict.delete_if() {|key, value| value < 10}
    puts dict
    users = {'Marco' => {'name' => 'Marco', 'email' => 'aurelio.pontes@gmail.com', 'emails' => ['email 1', 'email 2', 'email 3']}, 'Tamiris' => {'name' => 'Tamiris', 'email' => 'tamiris@gmail.com', 'emails' => ['email 4', 'email 5', 'email 6']}}
    puts users
    puts users['Marco']
    puts users['Tamiris']
  end

end


Main.new.main()



