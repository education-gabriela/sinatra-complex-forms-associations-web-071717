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
    @pet = Pet.create(params[:pet])

    if params[:pet][:owner_id]
      @pet.owner_id = params[:pet][:owner_id].first
    else
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id].to_i)
    @owners = Owner.all
    erb :'pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id].to_i)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    pet = Pet.find(params[:id].to_i)
    
    if !params[:owner][:name].empty?
      owner = Owner.new(params[:owner])
      params[:pet].delete(:owner_id)
    else
      owner = pet.owner
    end
    pet.owner = owner
    pet.update(params[:pet])

    redirect to "pets/#{  pet.id}"
  end
end