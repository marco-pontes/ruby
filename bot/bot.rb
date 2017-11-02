require 'yaml'
require './wordplay/wordplay'
class Bot
  attr_reader(:name)

  def initialize(options)
    @name = options[:name] || "Unnamed Bot"
    begin
      @data = YAML.load(File.read(options[:data_file]))
    rescue
      raise "Can't load bot data"
    end
  end

  def greeting
    random_response(:greeting)
  end

  def farewell
    random_response(:farewell)
  end

  def response_to(input)
    prepared_input = preprocess(input.downcase)
    sentence = best_sentence(prepared_input)
    responses = possible_responses(sentence)
    responses[rand(responses.size)]
  end

  private

  def possible_responses(sentence)
    responses = []
    #Find all patterns to try to match against
    @data[:responses].keys.each do |pattern|
      next unless pattern.is_a?(String)
      #For each pattern, see if the supplied sentence contains
      #a match. remove substituition symbols (*) before checking.
      #Push all responses to the responses array.
      if sentence.match('\b' + pattern.gsub(/\*/, '') + '\b')
        if pattern.include?('*')
          responses << @data[:responses][pattern].collect do |phrase|
            matching_selection = sentence.sub(/ˆ.*#{pattern}\s+/, '')
            phrase.sub('*', WordPlay.switch_pronouns(matching_selection))
          end
        else
          responses << @data[:responses][pattern]
        end

      end
    end
    if responses.empty?
      responses << @data[:responses][:default]
    end
    responses.flatten()
  end

  def best_sentence(input)
    hot_words = @data[:responses].keys.select do |k|
      k.class == String && k =~ /^\w+$/
    end
    WordPlay.best_sentence(input.sentences, hot_words)
  end

  def preprocess(input)
    perform_substitutions(input)
  end

  def perform_substitutions(input)
    @data[:presubs].each do |s|
      input.gsub!(s[0], s[1])
    end
    input
  end

  def random_response(key)
    random_index = rand(@data[:responses][key].length)
    @data[:responses][key][rand(random_index)].gsub(/\[name\]/, @name)
  end

end