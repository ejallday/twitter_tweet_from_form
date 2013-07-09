

class User < ActiveRecord::Base
 has_many :tweets

  def fetch_tweets!
    options = {}
    if last_tweet = self.tweets.order('created_at DESC').first
      options[:since_id] = last_tweet.twitter_id
    end

    timeline = Twitter.user_timeline(self.username, options)
    timeline.each do |tweet|
      self.tweets.create(:text => tweet[:text], :twitter_id => tweet[:id])
    end
  end

  # def tweets_stale?
  #   last_tweet_time = self.tweets.order('updated_at DESC').first.updated_at
  #   (Time.now - last_tweet_time)/60 > 15
  # end
end
