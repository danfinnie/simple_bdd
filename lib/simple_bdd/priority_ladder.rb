module SimpleBdd
  class PriorityLadder
    def initialize(specific_array, generalizations)
     @specific_array, @generalizations = specific_array, generalizations
    end

    def detect &blk
      @specific_array
    end
  end
end
