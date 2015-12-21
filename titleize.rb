class String
  def titleize
    self.split(" ").map{|word| word.capitalize}.join(" ")
  end
end

def titleize(str)
  str.capitalize.split.map do |word|
    %w{and the}.include?(word.downcase) ? word : word.capitalize
  end.join(' ')
end