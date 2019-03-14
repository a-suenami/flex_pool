module FlexTrans
  module Struct
    def self.new(*args, &block)
      klass = Class.new do
        @@attributes = []

        class << self
          def set_attrributes(*attributes)
            @@attributes ||= []
            @@attributes.concat(attributes)
            attr_reader(*attributes)
          end
        end

        set_attrributes(*args)

        def initialize(attributes)
          shortage_attributes = @@attributes - attributes.keys
          if shortage_attributes.any?
            raise ArgumentError, "Some attributes doesn't given: #{shortage_attributes}"
          end

          attributes.each do |name, value|
            instance_variable_set(:"@#{name}", value)
          end
        end
      end

      if block_given?
        klass.class_eval(&block)
      end

      klass
    end
  end
end
