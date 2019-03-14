require 'flex_trans/struct'

RSpec.describe FlexTrans::Struct do
  let(:klass) { FlexTrans::Struct.new(:id, :name) }

  it 'has some attributes and each getters' do
    object = klass.new(id: 1, name: 'Suenami Akira')
    expect(object.id).to eq(1)
    expect(object.name).to eq('Suenami Akira')
  end

  it 'doesn\'t have setters (complete constructor pattern)' do
    object = klass.new(id: 1, name: 'Suenami Akira')
    expect{ object.id = 2 }.to raise_error(NoMethodError)
    expect{ object.name = 'Yamada Taro' }.to raise_error(NoMethodError)
  end

  it 'can\'t construct without any attributes' do
    expect { klass.new(id: 1) }.to raise_error(ArgumentError, 'Some attributes doesn\'t given: [:name]')
  end

  it 'can define any instance methods' do
    klass = FlexTrans::Struct.new(:id, :first_name, :last_name) do
      def full_name
        first_name + ' ' + last_name
      end
    end
    object = klass.new(id: 1, first_name: 'Akira', last_name: 'Suenami')
    expect(object.full_name).to eq('Akira Suenami')
  end
end
