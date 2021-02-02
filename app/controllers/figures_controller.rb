class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    
    erb :'/figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  post '/figures' do

    @figure = Figure.create(params["figure"])
 

    unless params["title"]["name"].empty?
      @figure.titles << Title.create(params["title"])
      
    end
    unless params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params["landmark"])
    end
    @figure.save
   
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @landmark = nil
    erb :'/figures/show'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params["id"])
    @landmark = Landmark.find_or_create_by(name: params['landmark']['name'])

    @figure.update(name: params["figure"]["name"])
    unless params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
      
    end
    unless params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      
    end
    @figure.save

    redirect "figures/#{@figure.id}"
  end
end
