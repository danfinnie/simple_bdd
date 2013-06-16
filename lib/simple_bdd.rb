require "simple_bdd/version"
require "simple_bdd/core"
require "simple_bdd/named_nouns"

module SimpleBdd
    include SimpleBdd::Core
    include SimpleBdd::NamedNouns

    def self.included(base)
        base.extend(ClassMethods)
    end
end
