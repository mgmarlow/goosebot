# frozen_string_literal: true

module Goosebot
  module Underlords
    class Ability
      def initialize(attributes)
        attributes.each do |k, v|
          instance_variable_set("@#{k}", v)
          self.class.send(:attr_accessor, k)
        end
      end
    end
  end
end
