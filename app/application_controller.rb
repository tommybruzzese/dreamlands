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
    erb :input
  end
  
   get '/sign_up' do
    erb :sign_up
  end
  
  post '/sign_up' do 
    User.create({:name => params[:name],:username => params[:username], :password_hash => params[:password]})
    @user = User.find_by({:password_hash => params[:password], :username => params[:username]})
    if @user
      session[:user_id]= @user.id
      puts session[:user_id]
      redirect '/input'
    else
    end
    redirect '/'
  end
  
  post '/results' do
    Dream.create(:date => params[:date], :description => params[:description], :emotion => params[:emotion], :people => params[:people], :keywords => params[:keywords], :interpretation => params[:interpretation])
    @dreams = Dream.all
    erb :results
  end

end
