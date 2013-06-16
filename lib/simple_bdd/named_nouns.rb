module SimpleBdd
    module NamedNouns
        module ClassMethods
            def let_named!(instance_name, class_name, &constructor)
                let!(instance_name, &constructor)
                @named_nouns ||= {}
                @named_nouns[instance_name.to_sym] = class_name.to_s
            end
        end
    end
end
