require 'ripple'

module Ripple
  module Statistics
    class Sum
      include Ripple::Document
      property :client_data, Hash, :presence => true

      def self.bucket_name; "_#{super}"; end

      def update_with(value)
        self.reload
        self.client_data ||= {}
        statistic = self.client_data[Ripple.config[:client_name]] || {'sum' => 0.0, 'count' => 0}
        statistic['sum'] = statistic['sum'] + value
        statistic['count']   = (statistic['count'] + 1)
        self.client_data[Ripple.config[:client_name]] = statistic
        self.save
      end

      def count
        self.client_data.map{|h| h[1]['count']}.inject(0, &:+)
      end

      def sum
        self.client_data.map{|h| h[1]['sum']}.inject(0, &:+)
      end

      on_conflict do |siblings, c|
        resolved = {}
        siblings.reject!{|s| s.client_data == nil}
        siblings.each do |sibling|
          resolved.merge! sibling.client_data do |client_id, resolved_value, sibling_value|
            resolved_value['count'] > sibling_value['count'] ? resolved_value : sibling_value
          end
        end
        self.client_data = resolved
      end
    end

    Sum.bucket.allow_mult = true
  end
end
