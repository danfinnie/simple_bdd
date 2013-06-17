module SimpleBdd
  class PriorityLadder
    def initialize(specific_array, generalizations)
     @specific_array, @generalizations = specific_array, generalizations
    end

    def detect &blk
      generalize(@specific_array).detect(&blk)
    end

    private

    def generalize(arr)
      ret = []
      idx_generalize = arr.find_index { |term| @generalizations.has_key? term.to_sym }

      return [arr] unless idx_generalize

      first_bit = arr[0...idx_generalize]
      second_bit = arr[(idx_generalize+1)..-1]
      term = arr[idx_generalize]
      generalized_term = @generalizations[term.to_sym]
      generalize(second_bit).each do |generalized_second_bit|
        ret << (first_bit + [term] + generalized_second_bit)
        ret << (first_bit + [generalized_term] + generalized_second_bit)
      end

      ret
    end

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
