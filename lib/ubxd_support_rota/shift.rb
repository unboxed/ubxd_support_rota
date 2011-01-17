require 'yaml'

module UBXDSupportRota
  class Shift
    attr_reader :name, :comment

    def initialize(attributes = {})
      @name = attributes["name"]
      @comment = attributes["comment"]
    end

    def to_s
      "<name: \"#{@name}\" comment: \"#{@comment}\">"
    end

    def to_wiki_format(previous_shift, date)
      values = [date.strftime("%e %b %Y"), previous_shift.name] + [name] * 6 + [comment||""]
      <<EOT % values
! %s
| %s ||  %s || %s  || %s  ||  %s || %s || %s || %s
|-
EOT
    end
  end
end
