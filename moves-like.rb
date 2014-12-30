require 'ap'

Dir[File.join(".", "classes/*.rb")].each do |file|
  require_relative(file)
end

require_relative "grabber"

grabber = Grabber.new
grabber.grab

router = ObjCRouter.new(grabber)
router.route

