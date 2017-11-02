require './main'
require 'benchmark'

class BenchmarkMain

  def benchmark_divide_integers()
    main = Main.new
    b = Benchmark.measure do
      main.divide_integers(10, 3)
    end
    puts b
    Benchmark.bm do |bm|
      bm.report("test bm") do
        main.divide_integers(10, 3)
      end
    end
  end

  BenchmarkMain.new.benchmark_divide_integers

end