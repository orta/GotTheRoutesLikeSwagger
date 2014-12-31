gem 'nap'
require 'rest'
require 'json'

class Grabber
  def grab()

    root =  ARGV[0] || "https://api.artsy.net/api/v1/swagger_doc"

    # temp token, will last a week
    token = ARGV[1] || "JvTPWe4WsQO-xqX6Bts49kAFbpDMRfxHtzyVZOdgDeRPYIpvqhke4GQZxHXJh3zTBd_TjZ7DTLfumZrTfS8iVIx9l9U3PVmTaTYOkiyPjVT-BozVkpXWTSQZIKYybNoavnv2wWNVmgCVqorndmD_xQUVoUMFU-IWrezae6XU0BPQBUhUHO8WTWkBVu9m0CCCm0jCd_mEWxKp8KUiEqBuwJai6RGGiZgFzBpFwpUuQQ4="
    redownload = false
    get_new_apis = false
    
    if get_new_apis 
      puts "Downloading all routes"
      get_all_apis =  REST.get(root, {})
      if get_all_apis.ok?
        response = JSON.parse(get_all_apis.body)
        File.write( "offline/all.json", get_all_apis.body)
        @api_routes = response["apis"]
      end
    else
      response = JSON.parse( File.read("offline/all.json") )
      @api_routes = response["apis"]
    end

    @all = []
    @raw = []
        
    @api_routes.each do |api|
      route_apis =[]
      new_route = root + api["path"].sub("{format}", "json")
      local_path = "offline/" + api["path"]
      
      if File.exists? local_path
        response = JSON.parse( File.read(local_path) )
        route_apis = response
        
      elsif !redownload
        
      else
        puts "Downloading all #{new_route}"
        endpoints_request =  REST.get(new_route, {})
        if endpoints_request.ok?
          route_apis = JSON.parse(endpoints_request.body)
          File.write( local_path, endpoints_request.body)
        end
      end
      
      if route_apis and route_apis.is_a? Hash
        group = APIGroup.new(route_apis)
        @all << group
      end
    end

    @all
    @raw.flatten!
  end
  
  def all
    @all.first != nil ? @all : []
  end
  
  def raw
    @raw
  end
  
end
