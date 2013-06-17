module SimpleBdd
  class PriorityLadder
    def initialize(specific_array, generalizations)
     @specific_array, @generalizations = specific_array, generalizations
    end

    def detect &blk
      [@specific_array, general_array].detect(&blk)
    end

    private

    def general_array
      @specific_array.map { |term| @generalizations[term.to_sym] || term }
    end
  end
end
