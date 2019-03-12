module FlexPool
  class Mapper
    def self.map(relation, limit: nil, map_type:)
      [map_type.new(1, 'Akira Suenami')]
    end
  end
end
