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

    @figure = Figure.create(name: params["figure"]["name"])
    
    if !params["figure"]["title_ids"].empty?
      @figure.titles << Title.find_or_create_by(id: params["figure"]["title_ids"])
      @figure.save
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(name: params["landmark"]["name"])
      @figure.save
    end
    @figure.save
   
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    erb :'/figures/show'
  end

  patch '/figures/:id' do
    redirect "figures/#{@figure.id}"
  end
end
