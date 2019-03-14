class Case::Product < FlexTrans::CaseClass
end

class ProductPresenter < FlexTrans::CaseClass
  include FlexTrans::Presenter
end

class ProductMapper < FlexTrans::Mapper
  relation Product.where

  attribute :id
  attribute :product_name, from: :name

  mapping_klass Product

  def map
  end
end

pool = FlexTrans::Pool.instant_pool do |p|
  p.attribute = [ :id, :name, :price ]
end
pool.fetch

class FlexTrans::Pool
  def self.instant_pool(&block)
    pool = FlexTrans::Pool.new
    # pool.relation = relation
  end

  def initialize(relation)
    @base_relation = relation
  end

  def self.[](relation)
    FlexTrans::Pool.new(relation)
  end

  def fetch
    self.relation.limit()
  end

  def relation
    self.base
  end
end

rel = Member.where(...)
pool = FlexTrans::Pool[rel].attributes(:id, :name, :birth_date) do
  def age
    (Time.zone.now - birth_date).to_i
  end
end
members = pool.fetch(limit: 10)

class ProductMapper < FlexTrans::Mapper
  mapping_type Struct.new(:id, :name, :price)

  attribute :id
  attribute :name
  attribute :price
end

class FlexTrans::Mapper
  def self.map(relation)
    mapping_type = @@type || Struct.new(attributes)
    relation.map do |tupple|
      mapping_type.new(tupple)
    end
  end

  def attributes
    [:id, :name, :price]
  end
end
products = ProductMapper.map(relation)

FlexTrans::Mapper.map(relation)

class ProductPool < FlexTrans::Pool[Member]
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
