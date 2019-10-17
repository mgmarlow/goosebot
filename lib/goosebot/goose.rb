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
      tacobell
    ].freeze

    SUBREDDITS = %w[
      holdmybeer
      wheredidthesodago
      interestingasfuck
    ].freeze

    class << self
      def random_tag
        TAGS.sample
      end

      def random_subreddit
        SUBREDDITS.sample
      end
    end
  end
end
