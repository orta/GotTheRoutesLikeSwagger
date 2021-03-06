require 'mustache'

class ObjCRouter
  
  def initialize(grabber)
    @grabber = grabber
  end
  
  def route
    @grabber.all.each do |api_group|
      
      content =  "// Generated by Routes Like Swagger - #{Time.new.strftime("%d/%m/%y")}\n\n"
      content += "@interface ARRouter (#{api_group.name})\n"
      
      api_group.routes.each do |route|
        route.operations.each do |op|
          
          op.potential_selector_ends.each do |ends|
            method_params = ends.map(&:as_objc_route_param).join(" ")

            content += "\n/// #{op.summary} \n"
            content += ends.map do |param|
              "/// @param #{param.name} #{param.description}\n" 
            end.join("")
            
            content += "/// @return URLRequest for #{route.path}\n\n"
            
            unless op.has_no_required_params
              content += "- (NSURLRequest *)" + op.selector_base + "" + method_params.upcase_first_letter + ";\n"
            else
              spacer =  method_params.strip.length > 0 ? " " : ""
              content += "- (NSURLRequest *)" + op.selector_base + spacer + method_params + ";\n"
            end
          end
          
        end 
      end
      
      content += "@end"
      
      File.write("output/ARRouter+#{api_group.name}.h", content)
    end
  end
  
end
