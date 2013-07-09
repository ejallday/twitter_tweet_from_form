CURRENT = 'iericallen'

get '/' do
  erb :index
end

get'/tweet_form' do
  erb :tweet_form
end

get '/:username' do
  @user = User.find_or_create_by_username(params[:username])

  @user.fetch_tweets!

  if @user.tweets.empty?
    @error = "Either this user does not exist or they do not have any tweets."
    erb :tweets
  end

  @tweets = @user.tweets.order("twitter_id DESC").limit(10)
  erb :tweets
end

post '/tweet' do
  p params
  Twitter.update(params[:tweet][:body])
  redirect "/#{CURRENT}"
end
