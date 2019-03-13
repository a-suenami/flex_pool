require 'flex_pool/mapper'

RSpec.describe FlexPool::Mapper do
  it 'has the mapping attributes' do
    mapper = FlexPool::Mapper.mapping_attributes(:id, :name, :price)
    expect(mapper.current_mapping_attributes).to eq [:id, :name, :price]
  end

  it 'has the mapping type' do
    Product = Struct.new(:id, :name, :price)
    mapper = FlexPool::Mapper.mapping_attributes(:id, :name, :price).mapping_type(Product)
    expect(mapper.current_mapping_type).to eq Product
  end

  it 'has the default mapping type with FlexPool::Struct' do
    mapper = FlexPool::Mapper.mapping_attributes(:id, :name, :price)
    expect(mapper.current_mapping_type).to_not be nil
  end

  it "works (just fake it)" do
    relation = []
    objects = FlexPool::Mapper.mapping_attributes(:id, :name).map(relation, limit: 10)
    expect(objects).to be_a(Array)
  end

  # it 'map to defautl type (struct)' do
  #   # FlexPool::Mapper.map(relation, limit: 10)
  #   mapper = FlexPool::Mapper
  #     .map_attrs(:id, :name, :price)
  #     .map_type(MemberPresenter)

  #   # mapper = FlexPool::Mapper.attributes({ id: :memberId }, :name, :price)
  #   objects = mapper.map(relation, limit: 10)
  #   expect(objects.length).to eq 10
  # end

  # it 'map to specific type with default constructor' do
  #   # FlexPool::Mapper.map(relation, limit: 10, map_type: ProductViewModel)
  # end

  # it 'map to specific type with specific constructor' do
  #   # FlexPool::Mapper.map(relation, limit: 10, map_type: ProductViewModel, construct_with: :from_attributes)
  # end
end

# class Hoge
#     attr_reader :args
#
#     def initialize(*args)
#       @args = args
#     end
#   end
#
# >>hoge = FlexPool::Mapper[{ id: 'product_id' }, :name, :price]
#
#   hoge = FlexPool::Mapper.new do
#     map :id, from: 'id'
#     map :name, from: 'name'
#     map :price
#   end
#
#   class ProductMapper < FlexPool::Mapper
#     map :id, from: 'id'
#     map :name, from: 'name'
#     map :price
#   end
#
# >>- attributes
# >>- relation
# >>- limit
