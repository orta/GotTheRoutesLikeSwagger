class APIOperation
  attr_accessor :summary, :nickname, :method, :notes, :parameters, :route, :type, :params
  
  def initialize(*h, route)
    if h.length == 1 && h.first.is_a?(Hash)
      h.first.each { |k, v| send("#{k}=", v) }
    end
    
    if h.first["parameters"] 
      @parameters = h.first["parameters"].map do |op|
        APIParam.new(op, self)
      end
    end

    @route = route
  end
  
  # The minimum to fulfil the route
  def selector_base
    prefix = "/api/v1/"
    path = route.path.sub(prefix, "")
           .sub(".{format}", "")
           .gsub("/", "_")
           .camel_case
           .gsub("{", 'WithID:(NSString *)')
           .remove_prefix_bracket
           .gsub("}", " ")
           .gsub("*)id", "*)slug")
           .gsub("Id ", "ID ")
           .gsub("(WithID:(NSString *)imageVersion )", "") # these are optional, so I'm removing them for now, but could be turned into something
           .strip
           .remove_hanging_words
           .lowercase_after_spaces
    
    action = case method
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
  
  # array of arrays of params, either all, or required and optionals
  def potential_selector_ends
    useful = parameters.select { |p| p.paramType != "path" } # not in URL path
    required = useful.select { |u| u.required == true }
    optionals = useful.select { |u| u.required == false }

    if optionals.length == 0
      [useful]
    else
      [required, optionals]
    end
  end 
end