module Dry
  class Struct
    module Constructor
      def self.call(klass, options = {}, &block)
        fn = options.fetch(:fn, block)
        Module.new do
          define_method(:new) do |attributes = default_attributes|
            super(fn[attributes])
          end
        end
      end
    end
  end
end
