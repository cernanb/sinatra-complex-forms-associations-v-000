class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.name = params[:pet][:name]
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
    else
      @owner = Owner.find_by_id(params[:pet]["owner_id"])
    end
    @pet.owner = @owner
    @owner.pets << @pet
    @owner.save
    redirect to "pets/#{@pet.id}"
  end
end
