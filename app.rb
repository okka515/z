require "bundler/setup"
Bundler.require
require "sinatra/reloader" if development?
require "./models.rb"
require_relative "utils/date.rb"

enable :sessions

def logged_in?
    !!session[:user_id]
end

get '/' do
    if logged_in?
      puts "Good!"
      @post = Post.all
      erb :index
    else
      redirect '/login'
    end
end

get '/login' do
    erb :login
end

post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        @user = user
        redirect '/'
    else
        redirect '/login'
    end
end

get '/signup' do
    erb :signup
end

post '/signup' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    if user.persisted?
        session[:user] = user.id
        redirect '/login'
    else
        redirect '/signup'
    end
end

post '/post-content' do
    Post.create(content: params[:content], user_id: session[:user_id])
    redirect '/'
end

get '/post/:id' do
    @post = Post.find_by(id: params[:id])
    @comment = @post.comments
    erb :comment
end

post '/post/:id' do
  Comment.create(content: params[:content], post_id: params[:id], user_id: session[:user_id])
  redirect "/post/#{params[:id]}"
end


get '/reset_db' do
    User.delete_all
    Post.delete_all
    Comment.delete_all
end