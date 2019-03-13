require 'flex_pool/mapper'
require 'flex_pool/pool'

RSpec.describe FlexPool do
  it "has a version number" do
    expect(FlexPool::VERSION).not_to be nil
  end

  it "has any mappers" do
    relation = []
    objects = FlexPool::Mapper.map(relation, limit: 10, map_type: Struct.new(:id, :name))
    expect(objects).to be_a(Array)
  end

  it "has any pools" do
    # このへんのインターフェース考える
    pool = FlexPool::Pool[relation]
    pool.fetch(args)

    objects = FlexPool::Pool.fetch(attr1: 'value1', attr2: 12345, attar3: false)
    expect(objects).to be_a(Array)

    products = ProductPool.fetch(
                 keyword: 'MacBook',
                 price_amount_from: 100_000,
                 price_amount_to: 300_000,
                 price_unit: 'JPY',
                 limit: 10
               )
    expect(products).to be_a(Array)
  end

  it "has case class" do
    expect(true).to be(true)
  end

  it "has presenter helper" do
    expect(true).to be(true)
  end
end
