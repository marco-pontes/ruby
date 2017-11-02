#!/usr/bin/env ruby
# coding: utf-8
require 'bundler/setup'
require './pet'
require './dog'
require './cat'
require './variables'
require './parent'
require './subclass'
require './user'
require './encapsulation'
require './nesting'
require './module'
require './chess_pieces'
require './song'
require './dungeon'
require './string_extensions'
require './exceptions/custom_exception'
require 'net/http'
require 'ostruct'
require 'chronic'
require 'tmpdir'
require 'tempfile'
require 'csv'
require 'pstore'
require 'yaml'
require 'sqlite3'
require 'string_methods'
require 'webrick'
require 'benchmark'
require './wordplay/wordplay'
require './bot/bot'
#require 'compiled/cfactorial'

include NumberUtility

#=Main Ruby Learning Class

#
#==Methods covering many aspects of Ruby like:
#
#*Syntax
# *Code blocks
# *Expressions
#*Structure
# *Arrays
# *Ranges
# *Regular Expressions
# *String functions
#
#==Examples
#There are examples of several structures, from *structs* to *symbols*
#The project depends on some gems to work properly as specified by
# require 'bundler/setup'
# require 'chronic'

class Main
  Pi = 3.14
  def receive_func()
    puts 'method that executes a code block'
    yield("passed param")
  end

  def method_argument(&code_block)
    %w{a e i o u}.each(){|letter| code_block.call(letter)}
    puts code_block.parameters
  end

  def divide(x, y)
    puts x.to_f/y.to_f
  end

  def divide_integers(x, y)
    puts x.to_i/y.to_i
    x.to_i/y.to_i
  end

  def divide_integers?(x, y)
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
    #dates and times
    dates_and_times()
    #large numbers
    large_numbers()
    #ranges
    ranges()
    #symbols
    symbols()
    #conversions
    conversions()
    #variables
    variables()
    #inheritance
    inheritance()
    #override ruby existing standard methods
    override()
    #reflection
    reflection()
    #encapsulation
    encapsulation()
    #polymorphism
    polymorphism()
    #nested classes
    nested_classes()
    #modules
    modules()
    #dungeon game
    dungeon()
    #projects and libraries
    projects_and_libraries()
    #documentation
    #exceptions
    exceptions()
    #input
    files_and_directories()
    #databases
    databases()
    #relational databases
    relational_databases()
    #environment
    environment()
    #web servers
    web_servers()
    #execute programs
    advanced()
    #encoding
    encoding()
    #full program
    bot()
  end

  def bot()
    puts WordPlay.best_sentence(["this is a sentence about ruby", "this sentence has ruby ruby"], ["ruby"])
    puts WordPlay.switch_pronouns("this is your sentence about ruby this sentence has ruby ruby")
    bot  = Bot.new(:name => "Marbot", :data_file => "bot/mar.bot")
    puts bot.greeting()
    while input = gets and input.chomp() != 'goodbye'
      puts ">> " + bot.response_to(input)
    end
    puts bot.farewell()
  end

  def encoding()
    puts "test".encoding
    puts "çça vá".encoding
    begin
      "çça vá".encode("US-ASCII")
    rescue Encoding::UndefinedConversionError => e
      puts e.message
    end
  end

  def advanced()
    x = system("date")
    puts x
    x = `date`
    puts x
    if fork().nil?
        exec "ruby encapsulation.rb"
    end

    child = fork do
      sleep 1
      puts "Child says hi"
    end
    Process.wait child
    puts "done!"
    ls = IO.popen("ls", "r")
    while line = ls.gets
      puts line
    end
    threads = []
    for i in (1..10)
      thread = Thread.new() do
        puts "Current thread: " + Thread.current.to_s
        $stdout.flush()
      end
      threads << thread
    end
    puts "All threads: "+ Thread.list.inspect
    puts "Main Thread: " + Thread.main.inspect
    for i in 0..2
      thread = Thread.new do
        puts "Thread: " + Thread.current.to_s
        Thread.pass
      end
      threads << thread
    end
    threads.each(){|thread| thread.join()}
    sg = Fiber.new do
      s = 0
      loop() do #loop() loops forever
        square = s*s
        puts "Calling Fiber.yield"
        Fiber.yield(square)
        puts "After Yield"
        s += 1
      end
    end
    10.times do
      puts "Calling sg.resume: "
      puts sg.resume
    end

    sg = Fiber.new do
      s = 0
      loop() do #loop() loops forever
        square = s*s
        puts "Calling Fiber.yield"
        s += 1
        s = Fiber.yield(square) || s
        puts "After Yield"
      end
    end
    puts "Calling sg.resume: 40"
    puts sg.resume 40 #does not count due to flow
    puts "Calling sg.resume: 40"
    puts sg.resume 40
    puts "Calling sg.resume: "
    puts sg.resume
    puts 8.factorial
    bm = Benchmark.bm do |bm|
      bm.report("factorial: ") do
        10000.times() do
          8.factorial
        end
      end
    end
    #c = CFactorial.new
    #c.factorial(8)
  end

  def web_servers()
    #server = WEBrick::GenericServer.new(:Port => 1234)
    #trap('INT'){server.shutdown}
    #server.start do |socket|
    #  socket.puts Time.now
    #end
    #server = WEBrick::HTTPServer.new(:Port => 1234)
    #server.mount("/", MyServlet)
    #trap("INT"){server.shutdown}
    #server.start
  end

  def environment()
    puts RUBY_PLATFORM
    ENV.each{|var| puts var}
    puts ENV['OS'].to_s
    puts "test".non_vowels
  end

  def relational_databases()
    puts "is defined?" + defined?(SQLite3::Database).to_s
    $db = SQLite3::Database.new("sql/ruby.db")
    $db.results_as_hash = true
    #f = File.read("sql/users/create_table.sql")
   # $db.execute(f)
    f = File.read("sql/users/insert.sql")
    $db.execute(f)
    f = File.read("sql/users/select.sql")
    $db.execute(f) do |row|
      puts "Result row: " + row.to_s
    end
    name = "Douglas"
    age = 30
    gender = "Male"
    $db.execute("INSERT INTO users (name, age, gender) VALUES(? , ?, ?)", name, age, gender)
    f = File.read("sql/users/select.sql")
    $db.execute(f) do |row|
      puts "Result row: " + row.to_s
    end
    close_db()
  end

  def close_db
    $db.close
    puts "closed database connection"
  end

  def databases()
    csv = CSV.open('files/csv/database.csv')
    csv.each(){|person| p person}
    csv = CSV.parse(File.read('files/csv/database.csv'))
    p csv
    user1 = User.new()
    user1.name= "Marco"
    user1.age = 29
    user1.gender = "Male"
    store = PStore.new("files/storagefile")
    store.transaction do
      store[:people] ||= Array.new
      store[:people] << user1
    end
    puts user1.to_yaml
    yml = File.open('files/person.yaml', 'w')
    yml.puts(user1.to_yaml)
    yml.close

    yml = File.open('files/person.yaml', 'r')
    loaded = YAML.load(yml)
    puts "loaded user: " + loaded.name
    puts "loaded user: " + loaded.age.to_s
    puts "loaded user: " + loaded.class.to_s
  end

  def files_and_directories()
    puts "Please enter input: "
    # a = gets
    # puts "your input: " + a
    File.open("oliver.txt") do |f|
      puts f.gets
    end

    f = File.new('oliver.txt', 'r')
    puts f.gets
    f.close


    File.open("oliver.txt").each(","){|line| puts line}
    #commented for brevity
    #File.open("oliver.txt").each_byte(){|byte| puts byte}
    File.open("oliver.txt") do |f|
      2.times(){puts "test f.gets: " + f.gets}
    end
    array_of_lines = File.open("oliver.txt").readlines
    File.open("oliver.txt") do |f|
      2.times(){puts "test f.read(12): " + f.read(12) + " f.pos: " + f.pos.to_s}
    end
    File.open("oliver.txt") do |f|
      2.times(){puts "test f.read(12): " + f.read(12); f.pos=0}
    end

    File.open("files/opened-file.txt", "w") do |f|
      f.puts("test opened file")
    end

    File.open("files/logfile.txt", "a") do |f|
      f.puts(Time.now)
    end

    f = File.new("files/readwrite.txt", "r+")
    f.puts "test"
    f.pos = 0
    puts f.gets
    f.close

    puts File.new("files/readwrite.txt", "r").external_encoding.to_s
    puts File.new("files/readwrite.txt", "r:iso-8859-1").external_encoding.to_s

    File.new("files/will-be-renamed.txt", "w").close

    File.rename("files/will-be-renamed.txt", "files/renamed.txt")

    puts File::SEPARATOR

    puts File.expand_path("main.rb")

    f = File.open("main.rb", "r")
    f.seek(-10, IO::SEEK_END)
    puts f.gets

    puts f.mtime
    puts File.mtime("main.rb")
    puts File.exist?("files/not-there.txt")

    f = File.open('files/readwrite.txt', 'r')
    while !f.eof?
      puts f.getc
    end

    puts "current dir: " + Dir.pwd
    puts Dir.entries('files')

    Dir.foreach("files") do |dir|
      puts "Directory file: " + dir
    end
    puts Dir['files/*']

    if Dir.exist?"files/created"
      Dir.delete('files/created')
    else
      Dir.mkdir('files/created')
    end

    puts Dir.tmpdir

    filename = File.join(Dir.tmpdir, "ruby.dat")
    tmp = File.open(filename, 'w+')
    tmp.puts('test tmp file')
    tmp.pos=0
    puts tmp.gets
    tmp.close
    File.delete(filename)
    puts File.exist?(filename).to_s

    f = Tempfile.new("test.dat")
    puts f.path
    f.close
  end

  def exceptions()
    begin
      call_method_throws_exception('')
    rescue #any exception
      puts "Thrown any exception, recovered"
    end
    begin
      call_method_throws_exception('')
    rescue ArgumentError
      puts "Thrown exception, recovered from ArgumentError"
    end

    begin
      call_method_throws_exception(rand(10) > 5 ? '-9' : '')
      call_method_throws_exception('')#not executed
    rescue ArgumentError
      puts "rescued from ArgumentError"
    rescue CustomException
      puts "rescued from CustomException"
    end

    begin
      #a = 10/0
      call_method_throws_exception(rand(10) > 5 ? '-9' : '')
      call_method_throws_exception('')#not executed
    rescue ArgumentError => e
      puts "rescued from Exception:" + e.class.to_s + ' ' + e.message
    rescue CustomException => e
      puts "rescued from Exception" + e.class.to_s + ' ' + e.message
    rescue
      puts "rescued from Other Exception"
    end

    catch(:error) do
      for i in (0..5)
        puts i
        #next goes to the next iteration
        if i == 3
          throw :error
        end
      end
    end

    catch :test do #if we remove the catch `throw': uncaught throw :test
      test_method_throws()
    end
  end

  def test_method_throws()
    puts "test method throws"
    throw :test
  end

  def call_method_throws_exception(string)
    if string.empty?
      raise ArgumentError, "String must not be empty"
      #same as raise (ArgumentError.new("String must not be empty"))
    end
    if string == '-9'
      raise CustomException, "This is my custom Exception, argument invalid"
    end
  end

  def projects_and_libraries()
    puts "programming ruby".vowels.join('')
    puts "Ruby path to look for files using require:"
    puts $:
    #commented for speed
    #Net::HTTP.get_print('www.google.com', '/')
    url = URI.parse('http://www.rubyinside.com/')
    #response = Net::HTTP.start(url.host, url.port) do |http|
     # http.get(url.path)
    #end
    #content = response.body
    count = 0
    #content.each_line{|line| puts line if count == 0; count+=1}
    person = Struct.new(:name, :age)
    person = person.new("Marco", 29)
    puts person
    person = OpenStruct.new
    person.name = "Marco"
    person.age = 29
    puts person
    puts "Chronic installed string_methods: " + Chronic.parse('May 10th').to_s
  end

  def dungeon()
    player = Player.new("Marco Pontes")
    dungeon = Dungeon.new(player)
    puts dungeon.player.name
    dungeon.add_room(:largecave, "Large Cave", "A large cave", {:west => :smallcave})
    dungeon.add_room(:smallcave, "Small Cave", "A small claustrophobic cave", {:east => :largecave})
    dungeon.start(:smallcave)
    dungeon.go(:east)
    dungeon.go(:west)
  end

  def modules()
    puts StringUtility.method1
    method2
    puts NumberUtility.method1
    a = StringUtility::StringClass.new
    puts a.class
    puts "NumberUtility::NumberClass::Pi: " + NumberUtility::NumberClass::Pi.to_s
    puts "NumberClass::Pi: " + NumberClass::Pi.to_s
    puts "NumberUtility.method2: " + NumberUtility.method2.to_s
    puts "method2: " + method2.to_s
    puts "from Cat Class"+Cat.new("").method2.to_s
    puts "included from NumberUtility module: " + method2.to_s# defined in included module NumberUtility above, will be available to the whole class
    #Enumerable
    p = ChessPieces.new
    p.each(){|piece| puts piece}
    puts "Selected: " + p.select(){|piece| piece.start_with?("k")}.inspect
    puts "Sorted: " + p.sort().inspect
    #Comparable
    s1 = Song.new("Suzie Q", 320, 360)
    s2 = Song.new("California Dream", 100, 460)
    s3 = Song.new("What is Love", 128, 760)
    puts s1 <=> s2
    puts "s3.between?(s2, s1): " + s3.between?(s2, s1).to_s
    puts "s3 > s1: " + (s3 > s1).to_s
  end

  def nested_classes()
    n = Nesting.new
    n2 = Nesting::NestedClass.new
    n3 = n.give_me_nested()
    puts n.class
    puts n2.class
    puts n3.class
  end

  def polymorphism()
    a = [Cat.new("Hashi"), Dog.new("Preta"), Cat.new("batata")]
    a.each() do |animal| puts (animal.talk + ' ' + animal.name) end
    puts a[0].name
  end

  def encapsulation()
    e = Encapsulation.new("Marco Pontes")
    e2 = Encapsulation.new("Tamiris Pontes")
    puts e.name()
  end

  def reflection()
    a = [10, 11]
    b = 1
    c = ""
    puts "Methods for Array class:"
    puts a.class.to_s + a.methods.join(" ")
    puts "Private methods for Array class:"
    puts a.private_methods.join(' ')
    puts "Public methods for Array class:"
    puts a.public_methods.join(' ')
    puts "Protected methods for Array class:"
    puts a.protected_methods.join(' ')
    puts "Instance variables for Array class:"
    puts a.instance_variables.join(' ')
    puts "Methods for a Fixnum:"
    puts b.class.to_s + b.methods.join(" ")
    puts "Methods for a String:"
    puts c.class.to_s + c.methods.join(" ")
    puts "Methods for a Symbol:"
    puts :d.class.to_s + :d.methods.join(" ")
    v = Variables.new(10)
    puts "Instance variables for Variables class:"
    puts v.instance_variables.join(' ')
    puts "Class variables for Variables class:"
    puts Variables.class_variables
    puts "Public methods for Variables class:"
    puts v.public_methods.join(' ')
    puts v.is_a?(String)
    puts v.instance_of?(String)
    puts v.is_a?(Variables)
    puts v.instance_of?(Variables)
    u = User.new
    puts "User instance variables(empty)" #no instance variables
    puts u.instance_variables.join(' ' )
    puts "User public methods" #no instance variables
    puts u.public_methods.join(' ') #no instance variables
    u.name = "Marco"
    puts u.instance_variables.join(' ')
  end

  def override()

  end

  def inheritance()
    instance = Parent.new("Marco")
    instance2 = Subclass.new("Marco")
    instance.method1
    instance.method2
    instance2.method1
    instance2.method2
    puts instance.get_name()
    puts instance2.get_name()
    puts "Constant Parent " + Parent::P_constant.to_s
    puts "Constant Subclass " + Subclass::P_constant.to_s
  end

  def variables()
    $var = 10 #can be used anywhere in this class now
    variables = Variables.new(10)
    puts variables.get_class_property   #two '@' means its a static property
    variables2 = Variables.new(50)
    puts variables2.get_class_property
    puts variables
    puts variables2
    puts variables.get_object_property
    puts variables2.get_object_property
    puts Variables.count
    puts Variables.count2
  end

  def conversions()
    puts '12' + '10'
    puts 12 + 10
    puts '12'.to_i + '10'.to_i
    puts 12.to_s + 10.to_s
    puts 10.to_f
    puts '10'.to_f
    puts 'a'.class
  end

  def symbols()
    current = :symbol
    puts "symbol test" if current == :symbol
    puts "class " + :symbol.class.to_s
    person1 = {:name => "Marco", :age => 29}
    person2 = {:name => "Tamiris", :age => 29}
    puts person1[:name]
  end

  def ranges()
    ("A".."D").each{|letter| print letter}
    puts
    ('A'..'D').each{|letter| print letter}
    puts
    ('a'..'d').each{|letter| print letter}
    puts
    (12..32).each{|n| print n}
    puts
    puts ('A'..'F').class
    puts ('A'..'F').to_a.class
    puts ('A'..'F').to_a.inspect
    puts ('a'..'f').include? 'A'
    #range indexes
    #upto fixnum array collect
    a = 0.upto(20).collect {|a| a}
    puts a.class
    print a
    puts
    print a[1..4]
    #upto string array collect
    a = 'A'.upto('G').collect {|a| a}
    puts a.class
    print a
    puts
    print a[1..4]
    #range string array collect
    a = ('A'..'L').collect {|a| a}
    puts a.class
    print a
    puts
    print a[10..16] #end index is bigger than the array - no error
    puts
    print a[9..11]
    puts
    print ('a'..'c') #prints a representation of the range: a..c
    print ('a'..'c').collect {|a| a}
    puts
    a[12..15] = ['X', 'Y', 'Z']
    print a
    puts
    a[18..15] = ['a', 'a', 'c'] #increases array size, letting blank spaces
    print a
    puts
  end

  def large_numbers()
    r = 1
    64.times {|n|
      puts "number: #{n} = #{r} #{r.class}"
      r *= 2
    }
    puts 4611686018427387903.class
    puts 4611686018427387904.class
  end

  def dates_and_times()
    puts Time.now
    puts Time.now - 10.hours
    puts Time.now + 86400
    puts Time.now.class
    year = 2018
    month = 10
    day = 21
    hour = 14
    minute = 49
    second = 23
    puts Time.local(year, month, day, hour, minute, second)
    puts Time.gm(year, month, day, hour, minute, second)
    puts Time.utc(year, month, day, hour, minute, second)
    puts Time.utc(year, month, day, hour, minute, second).to_i

    time = Time.utc(year, month, day, hour, minute, second).to_i
    time2 = Time.at(time)
    puts time2.to_s + " " + Time.at(time2).to_s
    puts time2.year.to_s + " " + time2.day.to_s
    puts "string template #{time2.year} - #{time2.day}"
    puts Time.local(year, month, day, hour, minute, second).zone
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

    word = "pineapple"
    if word == "orange"
      puts "orange"
    elsif word == "apple"
      puts "red"
    elsif word == "pineapple"
      puts "yellow"
    end

    case word
      when "orange"
        puts "orange"
      when "apple"
        puts "red"
      when "pineapple"
        puts "yellow"
      else
        puts "unknown"
    end

    1.upto(5){|number| puts number}
    b = 1
    until b > 99
      puts b
      b = b * 2
    end

    b = 1
    while b < 99
      puts b
      b = b * 2
    end

    a = [1,2,3,4,5]
    a.each {|number| print number.to_s}
    a = 64
    a.times(){|n| print n}
    method_argument(){|vowel| puts vowel}
    test_var_method = lambda{|x| puts x}
    test_var_method.call("a")
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
    dog = Dog.new("batata")
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
    receive_func {|param| puts "aaaa Works " + param}
    divide(10, 3)
    divide_integers(10.0, 3.0)
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
    "this is a test".scan(/[a-o]/i) {|letter| puts letter} # i makes the regex case sensitive
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
    dict = Hash.new
    dict = {}
  end

end
class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    response.status = 200
    response.content_type = 'text/plain'
    response.body = Time.now.to_s
  end
end

def test()
  puts 'test procedural method'
end

class Fixnum
  def seconds
    self
  end
  def minutes
    self * 60
  end
  def hours
    self * 60 * 60
  end
  def days
    self * 60 * 60 * 24
  end
  def factorial
    (1..self).inject do |a,b|
      a * b
    end
  end
end

Main.new.main()



