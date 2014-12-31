class APIGroup
  attr_accessor :routes, :name
  
  def initialize(hash)
    @name = hash["resourcePath"].gsub("/", "_").camel_case
    
    if hash["apis"] 
      @routes = hash["apis"].map do |op|
        APIRoute.new(op, self)
      end
    else
      @routes = []
    end
  end
  
end