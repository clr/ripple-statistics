module Ripple
  # When mixed into a Ripple::Document class, this will encrypt the
  # serialized form before it is stored in Riak.  You must register
  # a serializer that will perform the encryption.
  # @see Serializer
  module Statistics
    class Error < StandardError; end

    module ClassMethods
      def statistics_properties
        @statistics_properties ||= {:average => [], :count => [], :sum => []}
      end

      [:average, :count, :sum].each do |operation|
        define_method "property_#{operation}".to_sym do |value, options={}|
          statistics_properties[operation] << value
          define_singleton_method "#{value}_#{operation}".to_sym do
            klass = "Ripple::Statistics::#{operation.to_s.capitalize}".constantize
            if(statistic = klass.find("#{bucket_name}_#{value}_#{operation}"))
              return statistic.send(operation)
            elsif options[:default]
              return options[:default]
            else
              raise Ripple::Statistics::Error, "No statistic found, and default value not specified."
            end
          end
        end
      end
    end

    def self.included klass
      if Ripple.config[:client_name].nil?
        raise Ripple::Statistics::Error, "Missing client identifier. Please set client_name in your ripple.config file."
      end
      klass.extend ClassMethods
    end

    def update_statistics
      self.class.statistics_properties.each do |operation, values|
        values.each do |value|
          id    = "#{self.class.bucket_name}_#{value}_#{operation}"
          klass = "Ripple::Statistics::#{operation.to_s.capitalize}".constantize
          statistic = klass.find(id) || klass.new
          statistic.key = id
          statistic.update_with self.send(value)
        end
      end
    end

    def save
      super
      update_statistics
    end
  end
end
