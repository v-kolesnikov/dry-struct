require 'dry/core/class_attributes'

module Dry
  class Struct
    module Options
      include Core::ClassAttributes

      def self.extended(base)
        base.instance_variable_set(:@meta, EMPTY_HASH)
        base.defines :options
        base.options EMPTY_HASH
      end

      def inherited(klass)
        super
        klass.instance_variable_set(:@meta, meta)
      end

      # @param [Hash] new_options
      # @return [Dry::Struct]
      def with(meta: self.meta, **new_options)
        Class.new(self) do |klass|
          klass.instance_variable_set(:@meta, meta)
          klass.options new_options
        end
      end

      # @overload meta
      #   @return [Hash] metadata associated with type
      #
      # @overload meta(data)
      #   @param [Hash] new metadata to merge into existing metadata
      #   @return [Dry::Struct] new type with added metadata
      def meta(data = nil)
        data ? with(meta: @meta.merge(data)) : @meta
      end

      # Resets meta
      # @return [Dry::Struct]
      def pristine
        with(meta: EMPTY_HASH)
      end
    end
  end
end
