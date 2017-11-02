class String
	def vowels
		self.scan(/[aeiou]/i)
	end
  def sentences
		gsub(/\n|\r/, '').split(/\.\s*/)
	end
  def words
		scan(/\w[\w'\-]*/)
	end
end