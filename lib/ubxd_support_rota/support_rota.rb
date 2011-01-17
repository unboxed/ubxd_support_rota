require 'yaml'

module UBXDSupportRota
  class SupportRota
    def self.create_from_yaml_file(filename)
      new.build_from_data(YAML.load(File.read(filename)))
    end

    def build_from_data(data)
      @start_date = Date.parse(data["start_date"].to_s)
      @support_sequence = data["support_sequence"].map { |s| Shift.new(s) }
      self
    end

    def to_s(format = nil)
      if format.to_s == "wiki"
        to_wiki_format
      else
        inspect
      end
    end

    # ==January 2011==
    # {| border="1"
    # ! Week Commencing !! Monday !! Tuesday !! Wednesday !! Thursday !! Friday !! Saturday !! Sunday !! Comment
    # |-
    # ! 3 Jan 11
    # |  Austin ||  Murray || Murray  || Murray  ||  Murray || Murray || Murray ||
    # |-
    # ! 10 Jan 11
    # | Murray || Nigel || Nigel ||Nigel  || Nigel  || Nigel || Nigel || (replaced Alex 'cos he's on baby-leave)
    # |-
    # ! 17 Jan 11
    # |  Nigel || Alan || Alan  || Alan  || Alan || Alan || Alan ||
    # |-
    # ! 24 Jan 11
    # | Alan ||  Jolyon ||  Jolyon ||  Jolyon ||  Jolyon ||  Jolyon ||  Jolyon ||
    # |-
    # ! 31 Jan 11
    # | Jolyon ||  Simon || Simon  || Simon  ||  Simon || Simon || Simon ||
    # |-
    # |}

    def to_wiki_format
      if @start_date.wday != 1
        raise "The start date should be a Monday"
      end

      s = header_for_date(@start_date)
      current_date = @start_date
      previous_shift = @support_sequence.shift

      @support_sequence.each_with_index do |shift, index|
        s += shift.to_wiki_format(previous_shift, current_date)
        previous_shift = shift
        current_date += 7
        if current_date.mday < 8
          s += footer
          unless index == @support_sequence.size - 1 # not the last shift in sequence
            s += header_for_date(current_date)
          end
        end
      end

      if current_date.mday >= 8
        s += footer
      end

      s
    end

    def header_for_date(date)
      <<EOT % [date.strftime("%B %Y")]
==%s==
{| border="1"
! Week Commencing !! Monday !! Tuesday !! Wednesday !! Thursday !! Friday !! Saturday !! Sunday !! Comment
|-
EOT
    end

    def footer
      "|}\n"
    end
  end
end
