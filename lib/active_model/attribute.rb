# frozen_string_literal: true

require "active_support/concern"
require "active_model"
require "active_model/type"

module ActiveModel
  module Attribute
    extend ActiveSupport::Concern

    included do
      include ActiveModel::AttributeMethods
      include ActiveModel::AttributeAssignment

      class_attribute :attributes, :attribute_registry,
                      instance_accessor: false,
                      instance_predicate: false

      self.attributes = []
      self.attribute_registry = {}

      attribute_method_suffix '='
      attribute_method_suffix '?'
    end

    class_methods do
      def attribute(name, type, options = {})
        name = name.to_s

        self.attribute_registry = attribute_registry.merge(name => [type, options])

        self.attributes = attribute_registry.keys

        define_attribute_method(name)

        attr_reader(name)
      end
    end

    def initialize(attrs = {})
      assign_attributes(attrs) if attrs

      super()
    end

    def attributes
      slice(*self.class.attributes)
    end

    def slice(*attrs)
      attrs.each_with_object({}) do |name, hash|
        hash[name] = send(name)
      end
    end

    private

    def attribute=(attr, value)
      type, options = self.class.attribute_registry[attr.to_s]
      casted_value = ActiveModel::Type.lookup(type, **options).cast(value)

      instance_variable_set(:"@#{attr}", casted_value)
    end

    def attribute?(attr)
      send(attr).present?
    end
  end
end
