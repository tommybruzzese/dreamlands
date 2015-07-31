require 'bundler'
Bundler.require
require './config/environment'
require './app/models/dream'
require './app/models/user'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'flatironninja'
  end
  
  helpers do
    def signed_in?
      session[:user_id]
    end
    
    def current_user
      current_user = User.find(session[:user_id])
    end
    
#     def error
#       session[:error]
#     end
  end
  
  get '/' do
    erb :index
  end
  
  
  get '/input' do
    if session[:user_id]
    erb :input
    else 
      erb :no_account2
    end
  end
  
   get '/sign_up' do
    erb :sign_up
  end
  
  get '/log_in' do
    erb :log_in
  end
  
  get '/results' do
    user = User.find(session[:user_id])
    user.dreams.each do |dream|
      puts dream.description
    end
      
#     @date = @dreams.date
#     @people = @dreams.people
    erb :results
  end
  
  post '/sign_up' do 
    User.create({:name => params[:name],:username => params[:username], :password_hash => params[:password]})
    @user = User.find_by({:password_hash => params[:password], :username => params[:username]})
    if @user
      session[:user_id]= @user.id
      puts session[:user_id]
      redirect '/'
    else
    end
    redirect '/'
  end
  
  post '/results' do
    Dream.create(:date => params[:date], :description => params[:description], :emotion => params[:emotion], :people => params[:people], :keywords => params[:keywords], :interpretation => params[:interpretation], :user_id => session[:user_id])
    user = User.find(session[:user_id])
    redirect '/results'
  end
  
  post '/delete' do
    Dream.destroy(params[:deletion])
    redirect '/results'
  end
  
  post '/sign_in' do
    @user = User.find_by({:username => params[:username], :password_hash => params[:password]})
    if @user
      session[:user_id]= @user.id
      puts session[:user_id]
      redirect '/'
    else
    end
    erb :no_account
  end
  
  get '/sign_out' do
    session[:user_id] = nil
    session[:error]
    redirect '/'
  end

end
