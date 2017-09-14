# frozen_string_literal: true

require "active_support/concern"
require "active_model/forbidden_attributes_protection"
require "active_model/attribute_assignment"
require "active_model/type"

module ActiveModel
  module Attribute
    extend ActiveSupport::Concern

    included do
      include ActiveModel::AttributeAssignment
    end

    class_methods do
      def inherited(subclass)
        subclass.attributes.replace(attributes)
      end

      def attributes
        @attributes ||= []
      end

      def attribute(name, type, **options)
        attributes << name unless attributes.include?(name)

        getter = name.to_sym
        setter = :"#{name}="

        define_method(getter) do
          @attributes[getter]
        end

        define_method(setter) do |value|
          @attributes[getter] = ActiveModel::Type.lookup(type, **options).cast(value)
        end
      end

      def alias_attribute(new_name, old_name)
        alias_method new_name, old_name
        alias_method :"#{new_name}=", :"#{old_name}="
      end
    end

    def initialize(attrs = {})
      @attributes = {}

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
  end
end
