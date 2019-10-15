# frozen_string_literal: true

module Goosebot
  class Goose
    TAGS = %w[
      burrito
      taco
      pizza
      doughnut
      butts
      bouldering
      yoga
    ].freeze

    def self.random_tag
      TAGS[rand(TAGS.count)]
    end
  end
end
