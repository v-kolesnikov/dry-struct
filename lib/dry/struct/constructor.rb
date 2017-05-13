module Dry
  class Struct
    class Constructor
      def self.call(klass, options = {}, &block)
        fn = options.fetch(:fn, block)
        Class.new(klass) do
          define_singleton_method(:new) do |attributes = default_attributes|
            super(fn[attributes])
          end
        end
      end
    end
  end
end
