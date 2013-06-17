module SimpleBdd
  class PriorityLadder
    def initialize(specific_array, generalizations)
     @specific_array, @generalizations = specific_array, generalizations
    end

    def detect &blk
      [@specific_array, *one_generality_array, general_array].detect(&blk)
    end

    private

    def general_array
      @specific_array.map { |term| @generalizations[term.to_sym] || term }
    end

    def one_generality_array
      0.upto(@specific_array.size-1).map do |i|
        term = @specific_array[i]
        generalization = @generalizations[term.to_sym]
        if generalization
          @specific_array[0...i] + [generalization] + @specific_array[(i+1)..-1]
        else
          nil
        end
      end.compact
    end
  end
end
