module FlexTrans
  class Pool
    # attr_reader :map_type

    def self.[](relation)
      new(relation)
    end

    def self.fetch(*args)
      map_type = Struct.new(:id, :name)
      [map_type.new(1, 'Akira Suenami')]
    end
  end
end
