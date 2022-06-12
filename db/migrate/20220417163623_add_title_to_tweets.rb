class AddTitleToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :title, :string
    add_column :tweets, :language, :string
  end
end
