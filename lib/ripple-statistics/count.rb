require 'ripple'

module Ripple
  module Statistics
    class Count
      include Ripple::Document
      property :client_data, Hash, :presence => true

      def update_with(value)
        self.reload
        self.client_data ||= {}
        statistic = self.client_data[Ripple.config[:client_name]] || {'average' => 0.0, 'count' => 0}
        statistic['count']   = (statistic['count'] + 1)
        self.client_data[Ripple.config[:client_name]] = statistic
        self.save
      end

      def count
        self.client_data.map{|h| h[1]['count']}.inject(0, &:+)
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
  end
end
