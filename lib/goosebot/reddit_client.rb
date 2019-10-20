# frozen_string_literal: true

module Goosebot
  module RedditClient
    def hot_posts(subreddit)
      reddit_client.subreddit(subreddit).hot.children
    end

    private

    def reddit_client
      @reddit_client ||= Redd.it(
        user_agent: "Goosebot:v0.1.0 (by /u/#{ENV['REDDIT_USERNAME']})",
        client_id:  ENV['REDDIT_CLIENT_ID'],
        secret:     ENV['REDDIT_SECRET'],
        username:   ENV['REDDIT_USERNAME'],
        password:   ENV['REDDIT_PASSWORD']
      )
    end
  end
end
