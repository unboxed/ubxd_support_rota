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
        "wiki (#{@start_date}) [" + @support_sequence.map(&:to_s).join(", ") + "]"
      else
        inspect
      end
    end
  end
end
