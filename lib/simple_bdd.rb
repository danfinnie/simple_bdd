require "simple_bdd/version"
require "simple_bdd/core"
require "simple_bdd/named_nouns"

module SimpleBdd
  def self.included(base)
    base.extend(ClassMethods)
  end

  %w[Given When Then And Also].each do |method|
    define_method(method) do |message|
      begin
        send methodize(message)
      rescue NoMethodError => error
        message_does_not_exist(
          methodize(message), error
        )
      end
    end

    alias_method method.downcase, method
  end

  PRESERVED_CHARS = '\\w'
  CONVERTED_CHARS = Regexp.escape(' /')

  def methodize(message)
    message
      .downcase
      .gsub(/[^#{PRESERVED_CHARS}#{CONVERTED_CHARS}]/, "")
      .gsub(/[#{CONVERTED_CHARS}]+/, "_")
  end

  if defined?(::RSpec)
    def message_does_not_exist(message, error)
      pending(message)
    end
  else
    def message_does_not_exist(message, error)
      raise error
    end
  end

  module ClassMethods
    def let_named!(instance_name, class_name, &constructor)
      let!(instance_name, &constructor)
      @named_nouns ||= {}
      @named_nouns[instance_name.to_sym] = class_name.to_s
    end
  end
end
