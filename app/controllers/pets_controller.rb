class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params["pet_name"])

    if params["owner_name"].empty?
      @pet.owner = Owner.find(params["owner"])
    else
      @pet.owner = Owner.create(name: params["owner_name"])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(name: params['pet']['name'])

    if params['pet']['owner_id'] != @pet.owner_id
      @pet.update(owner_id: params['pet']['owner_id'])
    end

    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params['owner']['name'])
      @pet.update(owner_id: owner.id)
    end

    redirect to "pets/#{@pet.id}"
  end
end