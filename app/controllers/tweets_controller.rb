class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
    # @user = User.find(session[:user_id])
    # @tweets = Tweet.find_by(session[:user_id])
    # erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
  end

  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect "/tweets/new"
      else
        @tweet = current_user.tweets.build(:content => params[:content])
        if @tweet.save
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/new"
        end
      end
    else
      redirect '/login'
    end
  end
end
