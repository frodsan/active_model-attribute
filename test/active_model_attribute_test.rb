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

  alias_attribute :full_name, :name
end

class Admin < User
  attribute :sudo, :boolean
end

class ActiveModelAttributeTest < Minitest::Test
  def test_class_attributes
    assert_equal User.attributes, %w[name description age active]
  end

  def test_inheritance
    assert_equal Admin.attributes, User.attributes + %w[sudo]
  end

  def test_casting
    user = User.new(
      name: "Francesco",
      description: "Developer",
      age: "322",
      active: "true"
    )

    assert_equal "Francesco", user.name
    assert_equal "Developer", user.description
    assert_equal 322, user.age
    assert_equal true, user.active
  end

  def test_attributes
    user = User.new(name: "Francesco", description: "Developer")

    assert_equal "Francesco", user.attributes["name"]
    assert_equal "Developer", user.attributes["description"]
  end

  def test_predicates
    user = User.new(active: false)

    refute user.active?
    refute user.name?

    user.name = "Francesco"
    user.active = true

    assert user.name?
    assert user.active?
  end

  def test_alias
    user = User.new(full_name: 'Francesco')

    assert user.full_name?
    assert_equal user.full_name, user.name
  end
end
