require 'minitest/autorun'
require './main'

class TestMain < Minitest::Test

  def test_divide_integers()
    main = Main.new
    assert_equal(3,main.divide_integers(10, 3))
  end

end