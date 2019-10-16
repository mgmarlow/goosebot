module Goosebot
  module RedditClient
    def reddit_client
      @reddit_client ||= Redd.it(
        user_agent: 'Goosebot:v0.1.0 (by /u/aiokko)',
        client_id:  ENV['REDDIT_CLIENT_ID'],
        secret:     ENV['REDDIT_SECRET'],
        username:   ENV['REDDIT_USERNAME'],
        password:   ENV['REDDIT_PASSWORD'],
      )
    end

    def hot_posts(subreddit) 
      reddit_client.subreddit(subreddit).hot.children
    end
  end
end