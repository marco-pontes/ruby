require 'minitest/autorun'
require_relative './wordplay'
class TestWordPlay < Minitest::Test
  def test_best_sentence
    sentences = ["this is a ruby test", "this is a ruby ruby test"]
    words = ["ruby", "test"]
    s = WordPlay.best_sentence(sentences, words)
    assert_equal("this is a ruby ruby test", s)
  end

  def test_basic_pronouns
    s = WordPlay.switch_pronouns("i am a robot")
    assert_equal("you are a robot", s)
    assert_equal("you are a person", WordPlay.switch_pronouns("i am a person"))
    assert_equal("you love me", WordPlay.switch_pronouns("i love you"))
  end
end