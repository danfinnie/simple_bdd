module SimpleBdd
  class PriorityLadder
    def initialize(specific_array, generalizations)
     @specific_array, @generalizations = specific_array, generalizations
    end

    def detect &blk
      [@specific_array, *one_generality_array, *two_generality_array, general_array].detect(&blk)
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

    def two_generality_array
      x = 0.upto(@specific_array.size-2).map do |i|
        term_1 = @specific_array[i]
        generalization_1 = @generalizations[term_1.to_sym]

        if generalization_1
          first_part = @specific_array[0...i] + [generalization_1]
          (i+1).upto(@specific_array.size-1).map do |j|
            term_2 = @specific_array[j]
            generalization_2 = @generalizations[term_2.to_sym]
            if generalization_2
                first_part + 
                @specific_array[(i+1)...j] +
                [generalization_2] +
                @specific_array[(j+1)..-1]
            else
              nil
            end
          end
        end
      end
      x.flatten(1).uniq.compact
    end
  end
end
