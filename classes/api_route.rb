class APIRoute
  attr_accessor :route, :operations
  
  def initialize(hash)
    @route = hash["path"]
    if hash["operations"] 
      @operations = hash["operations"].map do |op|
        APIOperation.new(op, self)
      end
    end
  end
  
  def hash
    @route.hash
  end
  
  def eql?(other)
    @route == other.route
  end
  
end