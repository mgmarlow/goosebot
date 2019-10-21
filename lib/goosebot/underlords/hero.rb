# frozen_string_literal: true

module Goosebot
  module Underlords
    class Hero
      def initialize(attributes)
        attributes.each do |k, v|
          instance_variable_set("@#{k}", v)
          self.class.send(:attr_accessor, k)
        end
      end

      def preview
        ability_text = abilities
                       .map { |ability| "**#{ability.name}**\n#{ability.description}" }
                       .join('\n')

        <<~DATA
          #{name}
          alignment: #{keywords}
          cost: #{cost}
          dmg: [#{damage_min.join(', ')}] - [#{damage_max.join(', ')}]
          armor: #{armor}

          #{ability_text}
        DATA
      end
    end
  end
end
