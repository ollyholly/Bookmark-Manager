require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  # ... app code here ...
  get '/' do
    'Hello world'
  end
  
  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmarks' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
