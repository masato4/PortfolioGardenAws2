class AddTweetUrlToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :tweet_url, :string
  end
end
