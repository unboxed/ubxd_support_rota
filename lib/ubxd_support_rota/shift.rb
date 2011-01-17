require 'yaml'

module UBXDSupportRota
  class Shift
    def initialize(attributes = {})
      @name = attributes["name"]
      @comment = attributes["comment"]
    end

    def to_s
      "<name: \"#{@name}\" comment: \"#{@comment}\">"
    end
  end
end
