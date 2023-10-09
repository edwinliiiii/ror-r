require 'net/http'
require 'json'

class V1::PokemonController < ApplicationController
  def index
    pokedexNumber = rand(1..1292) #there are currently 1292 pokemon that exist
    uri = URI('https://pokeapi.co/api/v2/pokemon/' + pokedexNumber.to_s)
    res = JSON.parse(Net::HTTP.get(uri))
    pokemon = { name: res['name'], types: res['types'], imageLink: res['sprites']['front_default'] }
    render json: pokemon, status: :ok
  end

  def all
    @pokemon = Pokemon.all
    render json: @pokemon, status: :ok
  end

  def create
    pokemon = Pokemon.new(create_pokemon_params)
    if pokemon.save
      render json: pokemon, status: :created
    else
      render json: pokemon.errors, status: :unprocessable_entity
    end
  end

  def destroy
    pokemon = Pokemon.find(params[:id])
    if pokemon.destroy!
      render json: params, status: 204
    else
      render pokemon.errors, status: 404
    end
  end
end
