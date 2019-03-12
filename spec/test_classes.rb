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

class ProductPool < FlexPool::Pool
  mapper
end
