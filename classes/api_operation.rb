class APIOperation
  attr_accessor :summary, :nickname, :method, :notes, :params, :route
  
  def initialize(hash, route)
    @summary = hash["summary"]
    @nickname = hash["nickname"]
    @method = hash["method"]
    @notes = hash["note"]
    @route = route
  end
  
end