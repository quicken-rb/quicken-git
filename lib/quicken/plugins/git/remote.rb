module Quicken
  module Plugins
    class Git < Quicken::Plugin
      class Remote
        attr_reader :name, :url
        
        def initialize name, url
          @name = name
          @url = url
        end
      end
    end
  end
end