class Analyzer
  def main
    text = ""
    line_count = 0
    File.open("oliver.txt").each() do |line|
      line_count += 1
      text << line
    end
    character_count = text.length
    no_spaces_char_count = text.gsub(/\s+/, "").length
    number_of_words = text.split(/\w+/).size
    number_of_sentences = text.split(/\?|!|\./).size
    sentences = text.gsub(/\s+/, ' ').strip.split(/\?|!|\./)
    sentences_sorted = sentences.sort_by {|sentence| sentence.length}
    one_third = sentences_sorted.length/3
    ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
    ideal_sentences = ideal_sentences.select(){|sentence| sentence =~/is|are/}
    puts ideal_sentences.join(".")
    number_of_paragraphs = text.split(/\n\n/).size
    words_per_sentence = number_of_words.to_f/number_of_sentences.to_f
    sentences_per_paragraph = number_of_sentences.to_f/number_of_paragraphs.to_f
    puts "Lines: #{line_count}"
    puts "Characters: #{character_count}"
    puts "Charracters (without spaces): #{no_spaces_char_count}"
    puts "Words: #{number_of_words}"
    puts text.scan(/\w+/).length
    puts "Sentences: #{number_of_sentences}"
    puts "Paragraphs: #{number_of_paragraphs}"
    puts "Words per Sentence: #{words_per_sentence}"
    puts "Sentences per Paragraph: #{sentences_per_paragraph}"
    stopwords = %w{the a by on for of are with just but and to the my I has some in}
    p stopwords.class
    words = text.scan(/\w+/)
    keywords = words.select(){|word| !stopwords.include?(word)}
    keywords = words.reject(){|word| stopwords.include?(word)}
    print keywords.join(' ')
    puts
    word_percentage = (keywords.size.to_f / words.size.to_f) * 100
    puts "Useful Words Percentage: #{word_percentage}%"
  end
end


Analyzer.new.main()