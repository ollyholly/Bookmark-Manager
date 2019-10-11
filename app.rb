require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './lib/database_connection_setup'
require './lib/comment'
require_relative './lib/tag'
require_relative './lib/bookmark_tag'
require_relative './lib/user'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    'Hello world'
  end
  
  get '/bookmarks' do
    @user = User.find(id: session[:user_id])
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmarks' do
    flash[:notice] = "Please submit a valid URL" unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end
  
  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect :'/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'/tags/new'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(content: params[:tag])
    BookmarkTag.create(bookmark_id: params[:id], tag_id: tag.id)
    redirect '/bookmarks'
  end

  get '/tags/:id/bookmarks' do
    @tag = Tag.find(id: params['id'])
    erb :'tags/index'
  end

  get '/users/new' do
    erb :'users/new'
  end
  
  post '/users' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect('/bookmarks')
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    
    if user
      session[:user_id] = user.id
      redirect('/bookmarks')
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/bookmarks')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
