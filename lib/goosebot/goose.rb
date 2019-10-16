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
      showerthoughts
    ]

    def self.random_tag
      TAGS[rand(TAGS.count)]
    end

    def self.random_subreddit
      SUBREDDITS[rand(SUBREDDITS.count)]
    end
  end
end
