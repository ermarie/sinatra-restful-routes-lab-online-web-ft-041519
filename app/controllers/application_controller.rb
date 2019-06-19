class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/' do
    redirect to "/recipes/new"
  end

  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  get "/recipes" do
    @recipes = Recipe.all
    binding.pry
    erb :index
  end

  post "/recipes" do
    @recipe = Recipe.create(params)

    redirect to "/recipes/#{@recipe.id}"
  end

  get "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    binding.pry
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])

    erb :edit
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update(title: params[:title], content: params[:content])
    erb :show
  end

  delete '/recipes/:id' do

    Recipe.destroy(params[:id])
    erb :index
  end


end
