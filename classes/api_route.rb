class APIRoute
  attr_accessor :path, :operations, :api
  
  def initialize(hash, api)
    @path = hash["path"]
    @api = api
    
    if hash["operations"] 
      @operations = hash["operations"].map do |op|
        APIOperation.new(op, self)
      end
    end
  end
  
  def hash
    @path.hash
  end
  
  def eql?(other)
    @path == other.path
  end
  
end