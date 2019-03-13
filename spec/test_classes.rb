class Case::Product < FlexPool::CaseClass
end

class ProductPresenter < FlexPool::CaseClass
  include FlexPool::Presenter
end

class ProductMapper < FlexPool::Mapper
  relation Product.where

  attribute :id
  attribute :product_name, from: :name

  mapping_klass Product

  def map
  end
end

pool = FlexPool::Pool.instant_pool do |p|
  p.attribute = [ :id, :name, :price ]
end
pool.fetch

class FlexPool::Pool
  def self.instant_pool(&block)
    pool = FlexPool::Pool.new
    # pool.relation = relation
  end

  def initialize(relation)
    @base_relation = relation
  end

  def self.[](relation)
    FlexPool::Pool.new(relation)
  end

  def fetch
    self.relation.limit()
  end

  def relation
    self.base
  end
end

rel = Member.where(...)
pool = FlexPool::Pool[rel].attributes(:id, :name, :birth_date) do
  def age
    (Time.zone.now - birth_date).to_i
  end
end
members = pool.fetch(limit: 10)

class ProductPool < FlexPool::Pool[Member]
  # mapping_class ProductPresenter
  mapping_class Struct.new(:id, :name, :price)

  attribute :id
  attribute :name
  attribute :price, from: :amount

  # ActiveRecord::Relation にモロ依存してしまうが、それでいいか…
  criteria :id
  criteria :upper_price, -> (value) { where('price > ?', value) }
  criteria :lower_price, -> (value) { where('price > ?', value) }
  criteria :keyword, -> (value) { where('name LIKE ?', "%#{value}%") }

  def fetch(limit: nil)
    relation.limit(limit).map do |record|
      mapping_class.new(record.to_h)
    end.map do |obj|
      obj.include(DefinedMethods)
    end
  end

  define_methods do
    def price
    end
  end
end
