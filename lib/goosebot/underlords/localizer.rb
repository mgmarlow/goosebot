# frozen_string_literal: true

module Goosebot
  module Underlords
    module Localizer
      def hero_names
        @hero_names ||= hero_data.map { |_, v| loc_data[v['displayName']].downcase }
      end

      def heroes
        return @heroes unless @heroes.nil?

        @heroes = hero_data.map do |_k, v|
          abilities = if v['abilities'].nil?
            []
          else
            v['abilities'].map do |a|
              dac_name = "dac_ability_#{a}"
              dac_description = "dac_ability_#{a}_description"
              dac_lore = "dac_ability_#{a}_lore"

              Underlords::Ability.new({
                name: ability_loc_data[dac_name],
                description: ability_loc_data[dac_description],
                lore: ability_loc_data[dac_lore]
              }.merge(ability_data[a]))
            end
          end

          Underlords::Hero.new(
            id:         v['id'],
            name:       loc_data[v['displayName']],
            armor:      v['armor'],
            damage_min: v['damageMin'],
            damage_max: v['damageMax'],
            cost:       v['goldCost'],
            health:     v['health'],
            keywords:   v['keywords'],
            abilities:  abilities
          )
        end
      end

      private

      def hero_data
        @hero_data ||= JSON.parse(File.read(heroes_path))
      end

      def ability_data
        @ability_data ||= JSON.parse(File.read(abilities_path))
      end

      def ability_loc_data
        @ability_loc_data ||= JSON.parse(File.read(abilities_loc_path))
      end

      def loc_data
        @loc_data ||= JSON.parse(File.read(loc_path))
      end

      def heroes_path
        File.expand_path('../../../data/underlords_heroes.json', __dir__)
      end

      def abilities_path
        File.expand_path('../../../data/underlords_abilities.json', __dir__)
      end

      def abilities_loc_path
        File.expand_path('../../../data/underlords_localization_abilities_en.json', __dir__)
      end

      def loc_path
        File.expand_path('../../../data/underlords_localization_en.json', __dir__)
      end
    end
  end
end
