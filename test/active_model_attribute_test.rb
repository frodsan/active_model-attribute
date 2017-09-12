require "bundler/setup"
require "minitest/autorun"
require_relative "../lib/active_model/attribute"

class User
  include ActiveModel::Attribute

  class TextType < ActiveModel::Type::String
    def type
      :text
    end
  end

  ActiveModel::Type.register(:text, TextType)

  attribute :name, :string
  attribute :description, :text
  attribute :age, :integer
  attribute :active, :boolean
end

class Admin < User
  attribute :sudo, :boolean
end

class ActiveModelAttributeTest < Minitest::Test
  def test_class_attributes
    assert_equal User.attributes, [:name, :description, :age, :active]
  end

  def test_inheritance
    assert_equal Admin.attributes, User.attributes + [:sudo]
  end

  def test_casting
    user = User.new(
      name: 'Francesco',
      description: 'Developer',
      age: '322',
      active: 'true'
    )

    assert_equal 'Francesco', user.name
    assert_equal 'Developer', user.description
    assert_equal 322, user.age
    assert_equal true, user.active
  end

  def test_attributes
    user = User.new(name: 'Francesco', description: 'Developer')

    assert_equal 'Francesco', user.attributes[:name]
    assert_equal 'Developer', user.attributes[:description]
  end
end
