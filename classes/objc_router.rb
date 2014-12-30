class ObjCRouter
  
  def initialize(grabber)
    @grabber = grabber
  end
  
  def route
    @grabber.all.each do |route|
      route.operations.each do |op|
        puts name_for_operation op
      end
    end
  end
  
  def name_for_operation operation
    prefix = "/api/v1/"
    path = operation.route.route.sub(prefix, "")
                                .sub(".{format}", "")
                                .gsub("/", "_")
                                .camel_case
                                .gsub("{", 'WithID:(NSString *)')
                                .remove_prefix_bracket
                                .gsub("}", " ")
                                .gsub("*)id", "*)slug")
                                .gsub("Id ", "ID ")
                                .gsub("(WithID:(NSString *)imageVersion )", "") # these are optional
                                .strip
                                .remove_hanging_words
                                .lowercase_after_spaces
    
    action = case operation.method
      when "GET"
        "get"
      when "POST"
         "create"
     when "DELETE"
        "remove"
      when "PUT"
         "update"
     end

     action + path
  end
  
end

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
end
