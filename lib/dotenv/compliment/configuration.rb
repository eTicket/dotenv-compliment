module Dotenv
  module Compliment
    class Configuration
      NO_KEY = Class.new(StandardError)

      ATTRIBUTES = [:host,
                    :port]

      def configure(&block)
        @fallback_values = config_class.new
        @fallback_values.instance_eval(&block)
      end

      ATTRIBUTES.each do |attribute|
        define_method(attribute) do
          get_key(attribute)
        end
      end

      private

      def config_class
        Class.new do
          ATTRIBUTES.each do |attribute|
            define_method(attribute) do |value|
              instance_variable_set(:"@#{attribute}", value)
            end
          end

          def get(var)
            instance_variable_get :"@#{var}"
          end

          def has?(var)
            instance_variable_defined?(:"@#{var}")
          end
        end
      end

      def get_key(key)
        return @fallback_values.get(key) if @fallback_values && @fallback_values.has?(key)
        raise NO_KEY, "No key given `#{key}'" unless ENV.key?(key.to_s)
        ENV[key.to_s]
      end
    end
  end
end
