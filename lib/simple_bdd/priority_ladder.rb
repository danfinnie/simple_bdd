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

    def generalize(term_list)
      if term_list.nil?
        yield []
        return
      end

      idx_generalize = term_list.find_index { |term| lookup_term(term) }

      unless idx_generalize
        yield []
        return
      end

      pre_term, term, post_term = split_array(term_list, idx_generalize)
      generalized_term = lookup_term(term)
      generalize(post_term) do |generalized_post_term|
        yield pre_term + [term] + generalized_post_term
        yield pre_term + [generalized_term] + generalized_post_term
      end
    end

    def split_array(arr, idx)
      [arr[0...idx], arr[idx], arr[(idx+1)..-1]]
    end

    def lookup_term key
      @generalizations[key.downcase.to_sym]
    end
  end
end
