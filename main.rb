class Main
  10.times do print "teste \n" end
  #print "2 + 3 is equal to " + 2 + 3
  #must convert to string first
  puts "2 + 3 is equal to: " + (2 + 3).to_s
  puts "integer arithmetic results in integer: " + (10/3).to_s
  puts "with a floating point: " + (10.0/3).to_s
end