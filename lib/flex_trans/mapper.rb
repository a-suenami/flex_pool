require 'flex_trans/struct'

module FlexTrans
  class Mapper
    class << self
      def mapping_attributes(*mapping_attributes)
        new(mapping_attributes: mapping_attributes)
      end

      def mapping_type(mapping_type)
        new(mapping_type: mapping_type)
      end
    end

    def initialize(mapping_attributes: [], mapping_type: nil)
      @mapping_attributes = mapping_attributes
      @mapping_type = mapping_type
    end

    def mapping_attributes(*mapping_attributes)
      new_attribues = (@mapping_attributes + mapping_attributes).uniq
      self.class.new(mapping_attributes: new_attribues, mapping_type: @mapping_type)
    end

    def mapping_type(mapping_type)
      self.class.new(mapping_attributes: @mapping_attributes, mapping_type: mapping_type)
    end

    def map(relation, limit: nil)
      # Just fake it
      [current_mapping_type.new(id: 1, name: 'Akira Suenami')]

      # relation.limit(limit).pluck(attributes).map do |record|
      #   mapping_type.new(record)
      # end
    end

    def current_mapping_type
      @mapping_type || FlexTrans::Struct.new(*current_mapping_attributes)
    end

    def current_mapping_attributes
      @mapping_attributes
    end
  end
end
