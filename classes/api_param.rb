class APIParam
  attr_accessor :allowMultiple, :name, :description, :type, :required, :format, :paramType, :operation, :enum, :defaultValue, :optional
  
  def initialize(*h, operation)
    if h.length == 1 && h.first.is_a?(Hash)
      h.first.each { |k, v| send("#{k}=", v) }
    end
    
    @operation = operation
    
    # if type != "query"
    #   puts "op: #{operation} query = #{type}"
    # end
  end
  
  def hash
    @route.hash
  end
  
  def eql?(other)
    @route == other.route
  end
  
  def as_objc_route_param
    camelName = name.camel_case.lowercase_first_letter.ending_id_is_caps
    "#{camelName}:(#{type_to_objc_param(type)})#{camelName}"
  end
  
  def type_to_objc (type)
    return "NSArray" if (type.start_with? "[") 
    { 
      "enum" => "NSString",
      "date" => "SWGDate",
      "Date" => "SWGDate",
      "boolean" => "NSNumber",
      "string" => "NSString",
      "integer" => "NSNumber",
      "int" => "NSNumber",
      "float" => "NSNumber",
      "long" => "NSNumber",
      "double" => "NSNumber",
      "Array" => "NSArray",
      "array" => "NSArray",
      "List" => "NSArray",
      "object" => "NSObject"
      }[type]
  end

  def type_to_objc_param (type)
    return "NSArray *" if (type.start_with? "[") 
    
    { 
      "enum" => "NSString *",
      "date" => "NSDate *",
      "Date" => "NSDate *",
      "boolean" => "BOOL",
      "string" => "NSString *",
      "integer" => "NSInteger",
      "int" => "NSInteger",
      "float" => "CGFloat",
      "long" => "CGFloat",
      "double" => "CGFloat",
      "Array" => "NSArray *",
      "array" => "NSArray *",
      "List" => "NSArray *",
      "object" => "id "
      }[type]
  end
  
end