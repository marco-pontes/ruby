require './string_extensions'
class WordPlay
  def self.best_sentence(sentences, desired_words)
    ranked = sentences.sort_by do |s|
      s.words.length - (s.downcase.words - desired_words).length
    end
    ranked.last
  end

  def self.switch_pronouns(text)
    text.gsub(/\b(I am|You are|I|You|Me|Your|My)\b/i) do |pronoun|
      case pronoun.downcase
        when "i"
          "you"
        when "you"
          "I"
        when "i am"
          "you are"
        when "you are"
          "i am"
        when "your"
          "my"
        when "my"
          "your"
      end
    end.sub(/ˆme\b/i, 'i')
  end
end