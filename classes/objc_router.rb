class ObjCRouter
  
  def initialize(grabber)
    @grabber = grabber
  end
  
  def route
    @grabber.all.each do |api_group|
      puts ""
      puts "-------- #{api_group.name} --"
      
      api_group.routes.each do |route|
        route.operations.each do |op|
          op.potential_selector_ends.each do |ends|
            method_params = ends.map(&:as_objc_route_param).join(" ")
            puts op.selector_base + " " + method_params
          end
        end 
      end
    end
  end
  
end
