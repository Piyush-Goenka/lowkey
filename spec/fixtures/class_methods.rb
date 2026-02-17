# frozen_string_literal: true

module Lowkey
  class ClassMethods
    def self.inline_class_method
      'goodbye'
    end

    def self.inline_class_method_with_arg(goodbye)
      goodbye
    end

    class << self
      def class_method_with_arg(goodbye)
        goodbye
      end

      def class_method_with_arg_and_default_value(goodbye = 'Bye')
        goodbye
      end
    end
  end
end
