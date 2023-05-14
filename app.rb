require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/post_repository'
require_relative 'lib/post'

DatabaseConnection.connect('chitter_testing_database')

class Application < Sinatra::Base
  configure :development do 
    register Sinatra::Reloader 
    also_reload 'lib/user_repository'
    also_reload 'lib/post_repository'
  end
  
  get '/' do
    return erb(:entry)
  end

  get '/home' do 
    @user_repo = UserRepository.new
    post_repo = PostRepository.new
    @posts = post_repo.all 
    return erb(:home)
  end

  post '/home' do 
    new_post = Post.new 
    new_post.peep = params[:peep]

    if (defined? @@id) != nil 
      new_post.user_id = @@id 
    else 
      new_post.user_id = 1
    end 

    post_repo = PostRepository.new
    post_repo.create(new_post)
    @posts = post_repo.all
    @user_repo = UserRepository.new    

    return erb(:home)
  end 

  get '/login' do
    return erb(:login)
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/login' do
    @user_repo = UserRepository.new
    post_repo = PostRepository.new
    @posts = post_repo.all 
    user = @user_repo.find_user(params[:username])
    @@id = user.id
    return erb(:home) if user.password == params[:password]
    return erb(:login) 
  end

  post '/signup' do
    user_repo = UserRepository.new 
    user = User.new 
    user.username = params[:username]
    user.email_address = params[:email_address]
    user.password = params[:password]
    user_repo.create(user)
    return erb(:login)
  end

end
