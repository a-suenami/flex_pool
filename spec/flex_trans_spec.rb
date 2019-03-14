require 'flex_trans/mapper'
require 'flex_trans/pool'

RSpec.describe FlexTrans do
  it "has a version number" do
    expect(FlexTrans::VERSION).not_to be nil
  end

  it "has any pools" do
    # # このへんのインターフェース考える
    # pool = FlexTrans::Pool[relation]
    # pool.fetch(args)

    # objects = FlexTrans::Pool.fetch(attr1: 'value1', attr2: 12345, attar3: false)
    # expect(objects).to be_a(Array)

    # products = ProductPool.fetch(
    #              keyword: 'MacBook',
    #              price_amount_from: 100_000,
    #              price_amount_to: 300_000,
    #              price_unit: 'JPY',
    #              limit: 10
    #            )
    # expect(products).to be_a(Array)
  end

  it "has case class" do
    expect(true).to be(true)
  end

  it "has presenter helper" do
    expect(true).to be(true)
  end
end
