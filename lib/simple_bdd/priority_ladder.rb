module SimpleBdd
  class PriorityLadder
    include Enumerable
    
    def initialize(specific_array, generalizations)
      @specific_array, @generalizations = specific_array, generalizations
    end

    def each &blk
      generalize(@specific_array, &blk)
    end

    private

    def generalize(arr, &blk)
      idx_generalize = arr.find_index { |term| @generalizations.has_key? term.to_sym }

      if !idx_generalize
        if arr.length > 0
          blk[[arr]]
        else
          blk[[]]
        end
        return
      end

      first_bit = arr[0...idx_generalize]
      second_bit = arr[(idx_generalize+1)..-1]
      term = arr[idx_generalize]
      generalized_term = @generalizations[term.to_sym]
      generalize(second_bit) do |generalized_second_bit|
        blk[first_bit + [term] + generalized_second_bit]
        blk[first_bit + [generalized_term] + generalized_second_bit]
      end
    end
  end
end
