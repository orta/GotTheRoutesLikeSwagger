class String
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map{|e| e.capitalize}.join
  end
  
  def remove_prefix_bracket
    self.end_with?("}") ? self[0..-2] : self
  end
  
  def remove_hanging_words
    return self unless self.include? "*" 

    components = self.split(" ")
    return self if components[-1].include? "*" 

    with_components = self.split("WithID:")
    with_components[-2] = with_components[-2] + components[-1]

    with_components.join("WithID:").split(" ")[0..-2].join(" ")
  end
  
  def lowercase_after_spaces
    self.gsub(/ [A-Z]/) { |s| s.downcase }
  end
  
  def lowercase_first_letter
    self.gsub(/^[A-Z]/) { |s| s.downcase }
  end
  
  def ending_id_is_caps
    self.gsub(/Id$/) { |s| s.upcase }
  end
  
  
end